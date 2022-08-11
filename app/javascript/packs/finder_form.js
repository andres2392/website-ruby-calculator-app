
jQuery(function(){

    $("#pump_type").on("change", function() {
        
        var optionSelected = $("option:selected", this);
        var str = this.value;
        

        if (str == "1"){
            
            $('#div-motor-volt').hide();
            $('#div-motor-phase').hide();
            $('#div-motor-wire').hide();
            $('#div-motor-type').hide();

            $('#div-submersible-type').show();
            $('#div-pump-assembly').show();
            var valueToSelect = 0;
            $('#select-pump-assembly').val(valueToSelect);

        }
        if (str == "2"){
            $('#div-motor-volt').hide();
            $('#div-motor-phase').hide();
            $('#div-motor-wire').hide();
            $('#div-motor-type').hide();

            $('#div-pump-assembly').show();
            var valueToSelect = 0;
            $('#select-pump-assembly').val(valueToSelect);
  
        }
        if (str == "3"){
            var valueToSelect = 0;
            $('#select-motor-volt').val(valueToSelect);
            $('#select-motor-wire').val(valueToSelect);
            $('#select-motor-phase').val(valueToSelect);
            $('#div-motor-volt').show();
            $('#div-motor-phase').show();

            $('#div-motor-wire').hide();
            $('#div-motor-type').hide();
            $('#div-submersible-type').hide();
            $('#div-pump-assembly').hide();
            $('#div-motor-type').hide();
        }
     });
  
     $('#select-pump-assembly').on("change", function() {
        var str = "";
        var optionSelected = $("option:selected", this);
        var str = this.value;
        if (str == 1){
            $('#div-motor-volt').hide();
            $('#div-motor-phase').hide();
            $('#div-motor-wire').hide();
        }  
        if (str == "2"){
            $('#div-motor-volt').show();
            $('#div-motor-phase').show();
            var valueToSelect = 0;
            $('#select-motor-volt').val(valueToSelect);
            $('#select-motor-phase').val(valueToSelect);
        }
        if(str == "2" && $('#pump_type').val() == "2"){
            $('#div-motor-type').show();
            var valueToSelect = 0;
            $('#select-motor-type').val(valueToSelect);
        }
     });

     $('#select-motor-phase').on("change", function() {
        var str = "";
        var optionSelected = $("option:selected", this);
        var str = this.value;
        
        if(str == "1" && $('#pump_type').val() == "1"){
            $('#div-motor-wire').show();
        }
        if(str == "2" && $('#pump_type').val() == "1"){
            $('#div-motor-wire').hide();
        }        
        if(str == "3" && $('#pump_type').val() == "1"){
            $('#div-motor-wire').hide();
        }
    });

    $('#select-motor-volt').on("change", function() {
        var str = "";
        var optionSelected = $("option:selected", this);
        var str = this.value;
        if(str == "1" ||str == "4"||str == "5"||str == "6" ){
            $('#div-motor-phase').hide();
            $('#div-motor-wire').hide();
        }else{
            $('#div-motor-phase').show();
        }

        if(str == 1 && $('#pump_type').val() == "1"){
            $('#div-motor-wire').show();
        }
    });

    

  });



