resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu_24_04.id
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnet_id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = var.key_name

  user_data = <<-EOT
    #!/bin/bash
    set -e

    apt-get update -y
    apt-get install -y nginx

    systemctl enable nginx
    systemctl start nginx
    echo "Hello from Ubuntu Nginx (Terraform Task 3)" > /var/www/html/index.html

    # ---- EBS Mount (Task 4) ----
    MOUNT_POINT="/data"
    mkdir -p "$MOUNT_POINT"

    # Detect root disk dynamically
    ROOT_SRC=$(findmnt -n -o SOURCE / || true)
    ROOT_DISK=$(lsblk -no PKNAME "$ROOT_SRC" 2>/dev/null || true)

    # If ROOT_DISK is empty, assume nvme0n1
    if [ -z "$ROOT_DISK" ]; then
      ROOT_DISK="nvme0n1"
    fi

    ROOT_DEV="/dev/$ROOT_DISK"

    DEVICE=""

    # Wait and pick the first NVMe disk that isn't the root disk
    for i in $(seq 1 30); do
      for d in /dev/nvme*n1; do
        if [ "$d" != "$ROOT_DEV" ]; then
          DEVICE="$d"
          break
        fi
      done

      if [ -n "$DEVICE" ] && [ -b "$DEVICE" ]; then
        break
      fi

      DEVICE=""
      sleep 2
    done

    if [ -z "$DEVICE" ] || [ ! -b "$DEVICE" ]; then
      echo "EBS device not found" >> /var/log/ebs-mount.log
      exit 0
    fi

    # Format only if it has no filesystem
    if ! blkid "$DEVICE" >/dev/null 2>&1; then
      mkfs.ext4 "$DEVICE"
    fi

    mount "$DEVICE" "$MOUNT_POINT"
    echo "$DEVICE $MOUNT_POINT ext4 defaults,nofail 0 2" >> /etc/fstab

    echo "EBS Mounted Successfully" > /data/ebs-test.txt
  EOT

  tags = { Name = "task3-nginx-ubuntu" }
}
