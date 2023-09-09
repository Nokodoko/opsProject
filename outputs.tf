output "control_plane_public_ip" {
  description = "Public IP of the control plane"
  value       = aws_instance.control_plane.public_ip
}
output "control_plane_private_ip" {
  description = "Private IP of the control plane"
  value       = aws_instance.control_plane.private_ip
}
output "worker_nodes_public_ips" {
  description = "Public IPs of the worker nodes"
  value       = aws_instance.worker_node[*].public_ip
}
output "worker_nodes_private_ips" {
  description = "Private IPs of the worker nodes"
  value       = aws_instance.worker_node[*].private_ip
}
