class AzuresController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @recent = AzureQuery.last
  end

  def show
  end

  def new
  end

  def create
    body = {
      kind: params[:type],
      analysisInput: {
        documents: [
          {
            id: "documentId",
            text: params[:text],
            language: "en"
          }
        ]
      },
      parameters: {
        domain: "none"
      }
    }

    data = connection.post("", body.to_json)

    q = AzureQuery.new(
      {
        query_type: params[:type],
        text: params[:text],
        result: data.body
      }
    )
    q.save

    redirect_to azures_path
  end

  private

  def connection
    return Faraday.new("https://bdntestaihealthtext.cognitiveservices.azure.com/language/:analyze-text?api-version=2023-11-15-preview&showStats=true") do |faraday|
      faraday.headers['Ocp-Apim-Subscription-Key'] = "a80419afc07e43949420d250d0834058"
      faraday.headers['Content-type'] = "application/json"
      faraday.options[:timeout] = 30
      faraday.adapter Faraday.default_adapter
    end
  end
end
