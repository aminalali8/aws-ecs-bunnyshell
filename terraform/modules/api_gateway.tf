resource "aws_api_gateway_rest_api" "api_gateway" {
  name = var.api_name
}

resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name  = var.api_stage_name
}
