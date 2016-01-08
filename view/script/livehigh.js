function g() {
	 alert("HIII");
    generateChart();

  }
 
function livehigh(json) {
 

 var data=[];
 var threshold=[];
 var len = json.finalGEO.length
 alert(len);
 i = 0;
 for (i; i < len; i++) {
     alert(json.GeoData[i]);
   /*  data.push(json.GeoData[i]);*/
     if (i === 0) {
         var dat = json.finalGEO[i].dataClasses,
         alert(dat);
             lenJ = dat.length,
             j = 0,
             tmp;

         for (j; j < lenJ; j++) {
        	 threshold.push(dat[j]);
         }
     } else {
         data.push(json.finalGEO[i].GeoData);
     }
 }
 alert(data);

    $(function () {
 
    
 
        $.each(data, function () {
            this.flag = this.code.replace('UK', 'GB').toLowerCase();
        });

        // Initiate the chart
        $("#graph1").highcharts('Map', {

            title: {
                text: 'Geowise User Experience'
            },
      
            exporting : {
                enabled : false
            },
            chart : {

                    backgroundColor:'transparent'
                           
            },
           
            credits : {
                enabled : false
            },
            legend: {
                 enabled: false,
                title: {
                    text: 'Average Response',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.textColor) || 'black'
                    }
                }
            },
           
            colorAxis: {

                dataClasses: threshold
            },

            mapNavigation: {
                enabled: true,
                enableButtons: false,
                buttonOptions: {
                    verticalAlign: 'bottom'
                }
            },

            tooltip: {
                backgroundColor: 'none',
                borderWidth: 0,
                shadow: false,
                useHTML: true,
                padding: 0,
                pointFormat: '<span class="f32"><span class="flag {point.flag}"></span></span>'
                    + ' {point.name}: <b>{point.value}</b>ms',
                positioner: function () {
                    return { x: 0, y: 250 };
                }
            },



            series : [{
                data : data,
                mapData: Highcharts.maps['custom/world'],
                joinBy: ['iso-a2', 'code'],
                name: 'Average Response',
                borderColor: '#000066',
                borderWidth: 1.2,
                states: {
                   
                }
            }]
        });
 
    
 
    
 
    });
 
    }
 
function generateChart()
{
 
chartType="livehigh";
$("#placeholder").text("");
 
     $.ajax({
            type: "GET",
            url:"../../GetChartDetails?jsonp="+chartType,
            dataType: 'jsonp',
            jsonpCallback: chartType, // the function to call
            error: function () {
                   console.log("Error is occured");
                    }
            });
 
}