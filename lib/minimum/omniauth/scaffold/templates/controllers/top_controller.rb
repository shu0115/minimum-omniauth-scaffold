class TopController < ApplicationController
  skip_before_action :authenticate

  # トップ
  def index
  end
end
