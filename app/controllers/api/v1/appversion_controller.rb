class API::V1::AppversionController < ApplicationController
  include API::V1::Appversion::Index
  include API::V1::Appversion::Delete
  include API::V1::Appversion::SetCount

  skip_before_filter :verify_authenticity_token


end
