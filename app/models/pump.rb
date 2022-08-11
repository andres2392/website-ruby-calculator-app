class Pump < ApplicationRecord
    has_many :user_pumps
    has_many :users, through: :user_pumps
    belongs_to :pump_family
    validates :name, :description, presence: true
   
    def self.check_db(pump_name)
        where(name: pump_name).first
    end


    def self.find_pump(pump_gpm, pump_ft,pump_fam, pump_assembly,pump_motor_volt, 
    pump_motor_phase, pump_motor_wire, pump_motor_type, pump_submersible_type)


        pumps_result = []
        #SUBMERSIBLE SEARCH
        if pump_fam == "SUBMERSIBLE"
            
            sub_pump_type = ""
            if pump_submersible_type == "0"
                pumps_result = submersible_pumps(pump_gpm, pump_ft,pump_fam, pump_assembly,pump_motor_volt,pump_motor_phase, pump_motor_wire, pump_motor_type, sub_pump_type)
            end

            if pump_submersible_type == "1"  
                sub_pump_type = "STAINLESS STEEL"
                pumps_result = submersible_pumps(pump_gpm, pump_ft,pump_fam, pump_assembly,pump_motor_volt,pump_motor_phase, pump_motor_wire, pump_motor_type, sub_pump_type)
            end

            if pump_submersible_type == "2"
                sub_pump_type = "STANDARD"
                pumps_result = submersible_pumps(pump_gpm, pump_ft,pump_fam, pump_assembly,pump_motor_volt,pump_motor_phase, pump_motor_wire, pump_motor_type, sub_pump_type)
            end

        #VPS SEARCH
        elsif pump_fam == "VERTICAL"
            vps_type = "VPS"
            pumps_result = vps_pumps(pump_gpm, pump_ft, vps_type, pump_assembly, pump_motor_volt, pump_motor_phase, pump_motor_wire, pump_motor_type, pump_submersible_type)
        end

        #puts "RESULT #{pump_result}"
       return pumps_result
 
    end


    def self.submersible_pumps(pump_gpm, pump_ft,pump_fam, pump_assembly,pump_motor_volt, 
        pump_motor_phase, pump_motor_wire, pump_motor_type, submersible_pump_material)
         
        pumps_result = []
       
        @pumps_fam = PumpFamily.where(pump_family: pump_fam, pump_sub_material: submersible_pump_material )
        #puts "FAMS #{@pumps_fam.name}"
        @pumps_fam.each do |fam|
            fid = fam.id
            #puts "FAMS NAME: #{fam.name} and ID : #{fid}"
            #Found fam in GPM range
            if fam.min_gpm <= pump_gpm && fam.max_gpm >= pump_gpm
                
                 #JUST PUMP END
                if pump_assembly == "PUMP END"
                    @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly)
                    pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                else
                    # MOTOR 115
                    if pump_motor_volt == "1"
                        if pump_motor_phase == "1" || pump_motor_phase == "0"
                            if pump_motor_wire == "1"
                                @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 115, phase: 1, pump_motor_type: "2 Wire" )
                                pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                            end
                            if pump_motor_wire == "2"
                                @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 115, phase: 1, pump_motor_type: "3 Wire" )
                                pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                            end
                            if pump_motor_wire == "3"  
                                @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 115, phase: 1)
                                pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                            end   
                        end
                        
                    end

                    #MOTOR 230
                    if pump_motor_volt == "2"

                        #puts "MOTOR 230 #{pump_motor_volt}"
                        if pump_motor_phase == "1"
                            if pump_motor_wire == "1"
                                @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 230, phase: 1, pump_motor_type: "2 Wire" )
                                pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                            end
                            if pump_motor_wire == "2"
                                @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 230, phase: 1, pump_motor_type: "3 Wire" )
                                pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                            end
                            if pump_motor_wire == "3" 
                                @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 230, phase: 1)
                                pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                            end 
                        end
                        if pump_motor_phase == "2"
                            @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 230, phase: 3)
                            pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                        end
                        if pump_motor_phase == "3" 
                            @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 230)
                            pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                        end
                        
                    end
                    #MOTOR 115/230
                    if pump_motor_volt == "3"
                        if pump_motor_phase == "1"
                            @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 115, phase: 1)
                            pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                            @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 230, phase: 1)
                            pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                        end
                        if pump_motor_phase == "2"
                            @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 115, phase: 3)
                            pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                            @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 230, phase: 3)
                            pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                        end
                        if pump_motor_phase == "3"
                            @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 115)
                            pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                            @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 230)
                            pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                        end
                        
                    end

                    #MOTOR 460
                    if pump_motor_volt == "4"
                        @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 460)
                        pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                    end
                    #MOTOR 230/460
                    if pump_motor_volt == "5"
                        @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 230)
                        pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                        @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly, volt: 460)
                        pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                    end

                    #MOTOR ANYA
                    if pump_motor_volt == "6" 
                        @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly)
                        pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                    end
                    
                    end
                end

        end
        #puts "PUMP RESULTS #{pumps_result}"
        return pumps_result

    end

    def self.vps_pumps (pump_gpm, pump_ft,pump_fam, pump_assembly,pump_motor_volt, 
        pump_motor_phase, pump_motor_wire, pump_motor_type, pump_submersible_type)
                
        pumps_result = []
       
        @pumps_fam = PumpFamily.where(pump_family: pump_fam )
        #puts "FAMS #{@pumps_fam.name}"
        @pumps_fam.each do |fam|
            fid = fam.id
            #puts "FAMS NAME: #{fam.name} and ID : #{fid}"
            #Found fam in GPM range
            if fam.min_gpm <= pump_gpm && fam.max_gpm >= pump_gpm
                #puts "FAMS GPM NAME: #{fam.name} and ID : #{fid}"
                 #JUST PUMP END
                if pump_assembly == "PUMP END"
                    @pump = Pump.where(pump_family_id: fid, pump_assembly: pump_assembly)
                    pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                else
                    if pump_motor_type == 1
                    end
                    pumps_result = vps_pump_volt(pump_gpm, pump_ft, pump_fam, pump_assembly, pump_motor_volt, pump_motor_phase, pump_motor_type, fid, pumps_result)                    
                end
            end

        end
        #puts "PUMP RESULTS #{pumps_result}"
        return pumps_result

    end

    def self.vps_pump_volt(pump_gpm, pump_ft,pump_fam, pump_assembly,pump_motor_volt,pump_motor_phase, pump_motor_type, fid, pumps_result)

        vps_pump_motor = ""

        if pump_motor_type == "0"
        elsif pump_motor_type == "1"
          vps_pump_motor = "IEC"
        elsif pump_motor_type == "2"
          vps_pump_motor = "NEMA-TEFC"
        elsif pump_motor_type == "3"
          vps_pump_motor = "NEMA-ODP"
        end
        
        # MOTOR 115
        if vps_pump_motor == ""
            if pump_motor_volt == "1"
                if pump_motor_phase == "1" || pump_motor_phase == "0"
                        @pump = Pump.where(pump_family_id: fid, pump_assembly: "PUMP", volt: 115, phase: 1 )
                        pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                end
                
            end
            #MOTOR 230
            if pump_motor_volt == "2"
                #puts "MOTOR 230 #{pump_motor_volt}"
                if pump_motor_phase == "1"
                        @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt: 230, phase: 1 )
                        pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                        @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt2: 230, phase: 1 )
                        pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                end
                if pump_motor_phase == "2"
                    @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt: 230, phase: 3 )
                    pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                    @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt2: 230, phase: 3 )
                    pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                end
                if pump_motor_phase == "3" 
                    @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt: 230 )
                    pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                    @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt2: 230 )
                    pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                end
                
            end
          
            #MOTOR 115/230
            if pump_motor_volt == "3"
                if pump_motor_phase == "1"
                    @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt: 115, volt2: 230, phase: 1)
                    pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                end
                if pump_motor_phase == "2"
                    @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt: 115, volt2: 230, phase: 3)
                    pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                end
                if pump_motor_phase == "3"
                    @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt: 115, volt2: 230)
                    pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                end
                
            end

            #MOTOR 460
            if pump_motor_volt == "4"
                @pump = Pump.where(pump_family_id: fid, pump_assembly: "PUMP", volt: 460 )
                pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                @pump = Pump.where(pump_family_id: fid, pump_assembly: "PUMP", volt2: 460 )
                pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
            end
            #MOTOR 230/460
            if pump_motor_volt == "5"
                @pump = Pump.where(pump_family_id: fid, pump_assembly: "PUMP", volt: 230, volt2: 460  )
                pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
            end

            #MOTOR ANYA
            if pump_motor_volt == "6" 
                @pump = Pump.where(pump_family_id: fid, pump_assembly: "PUMP")
                pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
            end     
        
        else
            if pump_motor_volt == "1"
                if pump_motor_phase == "1" || pump_motor_phase == "0"
                        @pump = Pump.where(pump_family_id: fid, pump_assembly: "PUMP", volt: 115, phase: 1 , pump_motor_type: vps_pump_motor)
                        pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                end
                
            end

            #MOTOR 230
            if pump_motor_volt == "2"

                #puts "MOTOR 230 #{pump_motor_volt}"
                if pump_motor_phase == "1"
                        @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt: 230, phase: 1 , pump_motor_type: vps_pump_motor)
                        pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                        @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt2: 230, phase: 1 , pump_motor_type: vps_pump_motor)
                        pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                end
                if pump_motor_phase == "2"
                    @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt: 230, phase: 3 , pump_motor_type: vps_pump_motor)
                    pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                    @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt2: 230, phase: 3 , pump_motor_type: vps_pump_motor)
                    pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                end
                if pump_motor_phase == "3" 
                    @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt: 230 , pump_motor_type: vps_pump_motor)
                    pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                    @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt2: 230 , pump_motor_type: vps_pump_motor)
                    pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                end
                
            end
            #MOTOR 115/230
            if pump_motor_volt == "3"
                if pump_motor_phase == "1"
                    @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt: 115, volt2: 230, phase: 1, pump_motor_type: vps_pump_motor)
                    pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                end
                if pump_motor_phase == "2"
                    @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt: 115, volt2: 230, phase: 3, pump_motor_type: vps_pump_motor)
                    pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                end
                if pump_motor_phase == "3"
                    @pump = Pump.where(pump_family_id: fid, pump_assembly:  "PUMP", volt: 115, volt2: 230, pump_motor_type: vps_pump_motor)
                    pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                end
                
            end

            #MOTOR 460
            if pump_motor_volt == "4"
                @pump = Pump.where(pump_family_id: fid, pump_assembly: "PUMP", volt: 460 , pump_motor_type: vps_pump_motor)
                pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
                @pump = Pump.where(pump_family_id: fid, pump_assembly: "PUMP", volt2: 460 , pump_motor_type: vps_pump_motor)
                pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
            end
            #MOTOR 230/460
            if pump_motor_volt == "5"
                @pump = Pump.where(pump_family_id: fid, pump_assembly: "PUMP", volt: 230,volt2:460, pump_motor_type: vps_pump_motor )
                pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
            end

            #MOTOR ANYA
            if pump_motor_volt == "6" 
                @pump = Pump.where(pump_family_id: fid, pump_assembly: "PUMP", pump_motor_type: vps_pump_motor)
                pumps_result = match_pump(@pump, pump_gpm, pump_ft, pump_fam, pumps_result)
            end     
        end
        return pumps_result
    end
      

    def self.match_pump(pump, pump_gpm, pump_ft, pump_fam, pumps_result)

        count = pumps_result.count
            #SUBMERSIBLE PUMPS
            if pump_fam == "SUBMERSIBLE"
                found = false 
                pump_ft_found = 0
                pump_gpm_found = 0
                pump_count_found = 0 
                pump_name_found =""  

                @pump.each do |pumpf| 
                    #puts "PUMP NAME #{pumpf.name}"
                    pump_array = pumpf.graph_points
                    pump_arr_count = pumpf.graph_points.count   
                    i = 0

                    if pump_count_found != 0 && pump_ft_found == pump_array[pump_count_found][1] && pump_gpm_found == pump_array[pump_count_found][0] && pump_name_found != pumpf.name
                        pumps_result[count] = pumpf
                        count += 1
                    end
        
                    while i <= pump_arr_count- 1 && found == false 
                        if pump_array[i][0] >= pump_gpm && pump_array[i][1] >= pump_ft
                                                
                            pump_found = pumpf
                            pump_ft_found = pump_array[i][1]
                            pump_gpm_found = pump_array[i][0]
                            pump_count_found = i 
                            pump_name_found = pumpf.name
                            #puts "PUMP NAME: #{pumpf.name} GPM #{pump_array[i][1]}" 
                            found = true
                            pumps_result[count] = pumpf
                            count += 1
                        end
                    i += 1
                    end
                end

            elsif pump_fam == "VPS"
                found = false 
                pump_ft_found = 0
                pump_gpm_found = 0
                pump_count_found = 0 
                pump_name_found =""  

                @pump.each do |pumpf| 
                    pump_array = pumpf.graph_points
                    pump_arr_count = pumpf.graph_points.count   
                    i = 0
                    if pump_count_found != 0 && pump_ft_found == pump_array[pump_count_found][1] && pump_gpm_found == pump_array[pump_count_found][0] && pump_name_found != pumpf.name
                        pumps_result[count] = pumpf
                        count += 1
                    end
        
                    while i <= pump_arr_count- 1 && found == false 
                        if pump_array[i][0] >= pump_gpm && pump_array[i][1] >= pump_ft
                                                
                            pump_found = pumpf
                            pump_ft_found = pump_array[i][1]
                            pump_gpm_found = pump_array[i][0]
                            pump_count_found = i 
                            pump_name_found = pumpf.name
                            puts "PUMP NAME: #{pumpf.name} GPM #{pump_array[i][1]}" 
                            found = true
                            pumps_result[count] = pumpf
                            count += 1
                        end
                    i += 1
                    end
                end

            end 
        return pumps_result 
    end

    def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
            company_hash = Pump.new
            company_hash.name = row[0]
            company_hash.description = row[1]
            company_hash.volt = row[2]
            company_hash.phase = row[3]
            company_hash.link = row[4]
            company_hash.graph_points = row[5]
            company_hash.pump_assembly = row[6]
            company_hash.pump_family_id = row[7]
            puts "ROW [[#{row[6]},#{row[7]}],[#{row[8]},#{row[9]}],[#{row[10]},#{row[11]}],[#{row[12]},#{row[13]}],[#{row[14]},#{row[15]}],[#{row[16]},#{row[17]}],[#{row[18]},#{row[19]}]]"
            points = "[[#{row[6]},#{row[7]}],[#{row[8]},#{row[9]}],[#{row[10]},#{row[11]}],[#{row[12]},#{row[13]}],[#{row[14]},#{row[15]}],[#{row[16]},#{row[17]}],[#{row[18]},#{row[19]}]]"
            puts "POINTS: #{points}"
            company_hash.graph_points = points
            puts "Company p: #{company_hash.graph_points}"
            #company_hash.save
        end
    end



end
