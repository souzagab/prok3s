# Download Ubuntu 20.04 cloudimg
wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img

# Install libguestfs-tools on Proxmox server.
apt-get install libguestfs-tools

# Install qemu-guest-agent on Ubuntu image.
virt-customize -a focal-server-cloudimg-amd64.img --install qemu-guest-agent

# Set environment variables. Change these as necessary.
export STORAGE_POOL="local-lvm"
export VM_ID="10000"
export VM_NAME="focal-se-cloudinit"

# Create Proxmox VM image from Ubuntu Cloud Image.
qm create $VM_ID --memory 2048 --net0 virtio,bridge=vmbr0
qm importdisk $VM_ID focal-server-cloudimg-amd64.img $STORAGE_POOL
qm set $VM_ID --scsihw virtio-scsi-pci --scsi0 $STORAGE_POOL:vm-$VM_ID-disk-0
qm set $VM_ID --agent enabled=1,fstrim_cloned_disks=1
qm set $VM_ID --name $VM_NAME

# Create Cloud-Init Disk and configure boot.
qm set $VM_ID --ide2 $STORAGE_POOL:cloudinit
qm set $VM_ID --boot c --bootdisk scsi0
qm set $VM_ID --serial0 socket --vga serial0