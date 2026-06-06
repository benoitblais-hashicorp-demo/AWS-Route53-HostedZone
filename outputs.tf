output "local_name_servers" {
  description = "A list of name servers for the local private hosted zone."
  value       = aws_route53_zone.local.name_servers
}

output "local_zone_id" {
  description = "The ID of the local private hosted zone."
  value       = aws_route53_zone.local.zone_id
}

output "local_zone_name" {
  description = "The name of the local private hosted zone."
  value       = aws_route53_zone.local.name
}

output "name_servers" {
  description = "A list of name servers for the hosted zone."
  value       = data.aws_route53_zone.public.name_servers
}

output "zone_id" {
  description = "The ID of the hosted zone."
  value       = data.aws_route53_zone.public.zone_id
}

output "zone_name" {
  description = "The name of the public hosted zone."
  value       = data.aws_route53_zone.public.name
}