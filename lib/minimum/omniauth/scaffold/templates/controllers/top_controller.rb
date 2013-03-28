class TopController < ApplicationController
  skip_before_filter :authenticate

  # トップ
  def index
  end
end
