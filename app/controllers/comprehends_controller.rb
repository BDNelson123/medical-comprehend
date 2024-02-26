class ComprehendsController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'aws-sdk-comprehendmedical'

  def index
    @recent = Query.last
  end

  def create
    client = Aws::ComprehendMedical::Client.new

    if params[:type] == "detect_entities_v2"
      resp = client.detect_entities_v2({
        text: params[:text], # required
      })
    elsif params[:type] == "detect_entities"
      resp = client.detect_entities({
        text: params[:text], # required
      })
    elsif params[:type] == "detect_phi"
      resp = client.detect_phi({
        text: params[:text], # required
      })
    elsif params[:type] == "infer_icd10cm"
      resp = client.detect_phi({
        text: params[:text], # required
      })
    elsif params[:type] == "infer_rx_norm"
      resp = client.infer_rx_norm({
        text: params[:text], # required
      })
    elsif params[:type] == "infer_snomedct"
      resp = client.infer_snomedct({
        text: params[:text], # required
      })
    end

    q = Query.new(
      {
        query_type: params[:type],
        text: params[:text],
        result: resp.to_json
      }
    )
    q.save

    redirect_to comprehends_path
  end
end
