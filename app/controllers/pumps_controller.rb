class PumpsController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_pump, only: [:show, :edit, :update, :destroy]

  # GET /pumps
  # GET /pumps.json
  def index
    @pumps = Pump.all
  end



  # GET /pumps/1
  # GET /pumps/1.json
  def show
    if @pump.name.include? "PW" 
      if @pump.pump_assembly == "PUMP AND MOTOR"
        nameArray = @pump.name.strip.split /\s+/
        if nameArray[0].include? "H"
          pump_series = nameArray[0].chomp('H')
          pump_mo = nameArray[1]
          pump_series_chop = pump_series[0,4]
          @pump_show = pump_series_chop+" "+pump_series[4,6]+ pump_mo[0,2]
          #puts "NAME #{@pump_show}"
        else 
            pump_series = nameArray[0]
            pump_mo = nameArray[1]
            pump_series_chop = pump_series[0,4]
            @pump_show = pump_series_chop+" "+pump_series[4,6]+ pump_mo[0,2]
            #puts "NAME #{@pump_show}"
        end
      end

      if @pump.name.include? "6PWS" or @pump.name.include? "8PWS" or @pump.name.include? "10PWS" 
        nameArray = @pump.name.strip.split /-/
        @pump_show =  nameArray[0]  
      end
    end

    if @pump.name.include? "VPS"
      
      if @pump.pump_assembly == "PUMP END"
        nameArray = @pump.name.strip.split /-/
        @pump_show = nameArray[0]+ "-"+nameArray[1]
      else
        nameArray = @pump.name.strip.split /\s+/
        @pump_show = nameArray[0]
        #puts "NAME #{@pump_show}"
      end

    end




  end

  # GET /pumps/new
  def new
    @pump = Pump.new
  end

  # GET /pumps/1/edit
  def edit
  end

  # POST /pumps
  # POST /pumps.json
  def create
    @pump = Pump.new(pump_params)

    respond_to do |format|
      if @pump.save
        format.html { redirect_to @pump, notice: 'Pump was successfully created.' }
        format.json { render :show, status: :created, location: @pump }
      else
        format.html { render :new }
        format.json { render json: @pump.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pumps/1
  # PATCH/PUT /pumps/1.json
  def update
    respond_to do |format|
      if @pump.update(pump_params)
        format.html { redirect_to @pump, notice: 'Pump was successfully updated.' }
        format.json { render :show, status: :ok, location: @pump }
      else
        format.html { render :edit }
        format.json { render json: @pump.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pumps/1
  # DELETE /pumps/1.json
  def destroy
    @pump.destroy
    respond_to do |format|
      format.html { redirect_to pumps_url, notice: 'Pump was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    if params[:pump].present?
      @pump = Pump.check_db(params[:pump])
      if @pump
        respond_to do |format|
          format.js { render partial: 'users/result'}
        end
      else
        respond_to do |format|
            flash.now[:alert] = "Please enter a valid name to search"
            format.js { render partial: 'users/result' }
        end
      end
    else
        respond_to do |format|
            flash.now[:alert] = "Please enter a name to search"
            format.js { render partial: 'users/result' }
        end
    end
  end

  def system_finder

    if current_user 
      @person = current_user
      @tracked_pumps = current_user.pumps
    end
    pump_gpm = params[:gpm].to_f
    pump_ft =  params[:ft].to_f
    pump_type = ""
    pump_assembly =  ""
    vps_pump_motor = ""
    pump_motor_volt =  params[:pump_motor_volt]
    pump_motor_phase =  params[:pump_motor_phase]
    pump_motor_wire =  params[:pump_motor_wire] 
    pump_motor_type =  params[:pump_motor_type] 
    pump_submersible_type = params[:pump_submersible_type]


    puts "PUMP PUMP"

    if params[:pump_type] == "0"    
    elsif params[:pump_type] == "1"
      pump_type = "SUBMERSIBLE"
    elsif params[:pump_type] == "2"
      pump_type = "VERTICAL"   
    elsif params[:pump_type] == "3"
      pump_type = "ABOVE GROUND"
    end

    if params[:pump_assembly] == "1" 
      pump_assembly = "PUMP END"
    elsif params[:pump_assembly] == "2"
      pump_assembly = "PUMP AND MOTOR"
    end

    if params[:pump_motor_type] == "0"
    elsif params[:pump_motor_type] == "1"
      vps_pump_motor = "IEC"
    elsif params[:pump_motor_type] == "2"
      vps_pump_motor = "NEMA-TEFC"
    elsif params[:pump_motor_type] == "3"
      vps_pump_motor = "NEMA-ODP"
    elsif params[:pump_motor_type] == "4"
      vps_pump_motor = "ANY"
    end

    puts "PUMP ASSEMBLY #{pump_assembly}, #{pump_type}, #{pump_motor_volt}, #{pump_motor_phase}, #{pump_motor_wire}, #{pump_motor_type}"
    
    if params[:gpm].present? && params[:ft].present? && params[:pump_type].present? && params[:pump_assembly].present? && pump_assembly != "" 
     
      @pumps = Pump.find_pump(pump_gpm, pump_ft, pump_type, pump_assembly, pump_motor_volt, 
                pump_motor_phase, pump_motor_wire, pump_motor_type, pump_submersible_type )
      
      #puts "PUMP COUNT #{@pumps.count}"
      if @pumps.count != 0
        respond_to do |format|
          format.js {render partial: 'users/gpm_result'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Pump specifications not found"
          format.js {render partial: 'users/gpm_result'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter values to search"
        format.js {render partial: 'users/gpm_result'}
      end
    end
  end





  def old_finder
    if params[:gpm].present? && params[:ft].present? && params[:pump_type].present? && params[:pump_assembly].present?
      @pumps = Pump.find_pump(pump_gpm, pump_ft, pump_type, pump_assembly, 
                pump_motor_volt, pump_motor_phase, pump_motor_wire, pump_motor_type)

      if @pumps
        respond_to do |format|
          format.js {render partial: 'users/gpm_result'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Pump specifications not found"
          format.js {render partial: 'users/gpm_result'}
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter values to search"
        format.js {render partial: 'users/gpm_result'}
      end
    end
  end


  def import
    Pump.import(params[:file])
    redirect_to root_url, notice: "Pumps imported."
  end

  def pump_name_picture
    @img_pump_curve = "submersible/#{@pump.name}-red.jpg"
    
    puts @img_pump_curve
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pump
      @pump = Pump.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pump_params
      params.require(:pump).permit(:name, :description, :volt, :phase, :pump_family_id, :pump_assembly, :graph_points, :link)
    end
    def pump_2
    end


end
