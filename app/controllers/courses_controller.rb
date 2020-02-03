class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    #response = HTTParty.get("http://dataservice.accuweather.com/locations/v1/cities/search?apikey=ss9ZJAG1LIKfs1BdWGRt40LFzAAvjALv&q=#{@course.city.name}")
    #raise response.body
    #@weather = HTTParty.get("http://dataservice.accuweather.com/currentconditions/v1/28143?apikey=ss9ZJAG1LIKfs1BdWGRt40LFzAAvjALv")
    weather = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?q=santiago&appid=0e605918296a37f23e96dcdc3239fb23")
    @weather_body = JSON.parse(weather.body)
    forecast = HTTParty.get("http://api.openweathermap.org/data/2.5/forecast?q=santiago&appid=0e605918296a37f23e96dcdc3239fb23")
    @forecast_body = JSON.parse(forecast.body)["list"].first
  end

  # GET /courses/new
  def new
    @course = Course.new
    @cities = City.all.collect do |c| [c.name, c.id] end
  end

  # GET /courses/1/edit
  def edit
    @cities = City.all.collect do |c| [c.name, c.id] end
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    date = params[:course][:date]
    time = params[:course][:time]
    new_date = DateTime.strptime((date+" "+format('%02d',time)+":00:00"), '%m/%d/%Y %H:%M:%S')
    @course.start_time = new_date
    respond_to do |format|
      if @course.save
        @course.create_events(new_date)
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    date = params[:course][:date]
    time = params[:course][:time]
    new_date = DateTime.strptime((date+" "+format('%02d',time)+":00:00"), '%m/%d/%Y %H:%M:%S')
    update_events = false
    if @course.start_time != new_date
      @course.start_time = new_date
      update_events = true
    end
    respond_to do |format|
      if @course.update(course_params)
        if update_events
          @course.update_events(new_date)
        end
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :description, :start_time, :days, :city_id)
    end
end
