# WAF Web ACL
resource "aws_wafv2_web_acl" "waf_acl" {
  name        = "secure-waf-acl"
  scope       = "REGIONAL"
  description = "WAF ACL for ALB protection"
  default_action {
    allow {}
  }

  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "commonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "secureWAF"
    sampled_requests_enabled   = true
  }

  tags = {
    Name = "secure-waf-acl"
  }
}

# Associate WAF ACL with ALB
resource "aws_wafv2_web_acl_association" "waf_alb_assoc" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.waf_acl.arn
}
