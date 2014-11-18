
class ReportsController < ApplicationController

def index

end

def create
  @report = Report.new(params[:zip_code])
end

def show

end

end
