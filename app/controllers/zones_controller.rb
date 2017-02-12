class ZonesController < ApplicationController
  def search
    zipcode = params[:zipcode]
    unless zipcode
      render status: 400, json: {errors: {zone: ['must be provided']}}
      return
    end

    zone = ZoneLookup.by_zipcode(zipcode)
    if zone
      render status: 200, json: {zone: zone}
    else
      render status: 400, json: {errors: {zone: ['is not valid']}}
    end
  end
end