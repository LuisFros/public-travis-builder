resource "aws_cloudfront_distribution" "entrega_final_cdf" {
  origin {
    domain_name = aws_s3_bucket.entrega-final-bucket.bucket_regional_domain_name
    origin_id   = "S3-entrega-final-bucket"
  }
  enabled = true
  is_ipv6_enabled=  true
  default_root_object = "index.html"
  custom_error_response {
    error_caching_min_ttl= 10
    error_code= 403
    response_code= 200
    response_page_path= "/index.html"
}

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id=  "S3-entrega-final-bucket"
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
       forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }
 restrictions { 
      geo_restriction {
                  restriction_type= "none"
                  }
              }
            
  viewer_certificate {
                cloudfront_default_certificate=true
                minimum_protocol_version= "TLSv1"
              }
}