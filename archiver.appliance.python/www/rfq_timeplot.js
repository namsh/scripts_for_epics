// Author  : Jeong Han Lee
// email   : jhlee@ibs.re.kr
//
// From RCCS IOC

//  Heater
// RFQ:TT:H03
// RFQ:TT:H05

// Pressure
// RFQ:PT:H01
// RFQ:PT:H02

// Tank
// RFQ:LT:H01


var timeplot1 = null;
var timeplot2 = null;
var timeplot3 = null;
var timeplot4 = null;
var timeplot5 = null;

function onLoad() {

    // var color1 = new Timeplot.Color('#FFD176');
    // var color2 = new Timeplot.Color('#FFB43D');
    // var color3 = new Timeplot.Color('#EB800F');
    var color4 = new Timeplot.Color('#964D1D');
    // var color5 = new Timeplot.Color('#66463E');
    var quietLine  = new Timeplot.Color('#82A6A2');
    // var loudLine   = new Timeplot.Color('#284452');
    // var lightFill  = new Timeplot.Color('#DEE5D1');
    var gridColor  = new Timeplot.Color('#888888');

    var blue   = new Timeplot.Color("#455681");
    var azur   = new Timeplot.Color("#0090FF");
    var yellow = new Timeplot.Color("#ffd700");
    var orange = new Timeplot.Color("#BB4A1B");
    var red    = new Timeplot.Color("#ff0000");
    var green = new Timeplot.Color('#468966');
    var lightGreen = new Timeplot.Color('#5C832F');

    var gridColor  = new Timeplot.Color('#333333');


    var monitor1URL = "./data/rfq_tt_h03_ai.txt";
    var monitor2URL = "./data/rfq_tt_h05_ai.txt";
    var monitor3URL = "./data/rfq_pt_h01_ai.txt";
    var monitor4URL = "./data/rfq_pt_h02_ai.txt";
    var monitor5URL = "./data/rfq_lt_h01_ai.txt";
    
    var timeGeometry = new Timeplot.DefaultTimeGeometry({
        gridColor: gridColor
    	, axisLabelsPlacement: "bottom"
    	, min : 0

    });

    var valueGeometry1 = new Timeplot.DefaultValueGeometry({
        gridColor: gridColor
	, gridType: "short"
    	, axisLabelsPlacement: "left"
    //	, min : 0
    	// , max : 30
    });

//     var geometry2 = new Timeplot.DefaultValueGeometry({
// //	min: 0
//     });

    
    var eventSource1 = new Timeplot.DefaultEventSource();
    var dataSource1  = new Timeplot.ColumnSource(eventSource1,1);
    //    var avgDataSource1 = new Timeplot.Processor(dataSource1, Timeplot.Operator.average, { size:600 });
    // var eventSource2 = new Timeplot.DefaultEventSource();
    // var dataSource2 = new Timeplot.ColumnSource(eventSource2,1);

    var plotInfo1 = [
        Timeplot.createPlotInfo
	({
            id: "RFQ:TT:H03"
	    , dataSource: dataSource1
	    , timeGeometry: timeGeometry
	    , valueGeometry: valueGeometry1
	    , lineColor: green
	    //  , dotColor: lightGreen
	    , showValues: true
	    , roundValues: false
        }),
 	// Timeplot.createPlotInfo
 	// ({
 	//     id: "RFQ:TT:05"
 	//     , dataSource: dataSource2
 	//     , timeGeometry: timeGeometry
 	//     , valueGeometry: geometry2
 	//     , lineColor: red
   	//     , dotColor: red.lighten(60)
	//     , fillColor: quietLine.lighten(60)
 	//     , showValues: true
 	//     , roundValues: false
	//     , valuesOpacity: 40
	//     ,  bubbleWidth: 1500
	//     ,  bubbleHeight: 1500
	//     , eventLineWidth: 0.1
 	// })
  
 
    ];
    
    timeplot1 = Timeplot.create(document.getElementById("rfq-timeplot1"), plotInfo1);
    timeplot1.loadText(monitor1URL, ",", eventSource1);
    // timeplot1.loadText(monitor2URL, ",", eventSource2);

    

    var valueGeometry2 = new Timeplot.DefaultValueGeometry({
        gridColor: gridColor
	, axisLabelsPlacement: "left"
    });
    
    
    var eventSource2 = new Timeplot.DefaultEventSource();
    var dataSource2  = new Timeplot.ColumnSource(eventSource2,1);
    var plotInfo2 = [
    	Timeplot.createPlotInfo
    	({
    	    id: "RFQTTH5"
    	    , dataSource: dataSource2
    	    , timeGeometry: timeGeometry
    	    , valueGeometry: valueGeometry2
	    , lineColor: red
 //   	    , dotColor: green.lighten(30)
    	    , showValues: true	    
    	    , roundValues: false

    	})

 
    ];
    
    timeplot2 = Timeplot.create(document.getElementById("rfq-timeplot2"), plotInfo2);
    timeplot2.loadText(monitor2URL, ",", eventSource2);


    

    var valueGeometry3 = new Timeplot.DefaultValueGeometry({
        gridColor: gridColor
	, axisLabelsPlacement: "left"
    });
    
    
    var eventSource3 = new Timeplot.DefaultEventSource();
    var dataSource3  = new Timeplot.ColumnSource(eventSource3,1);
    var plotInfo3 = [
    	Timeplot.createPlotInfo
    	({
    	    id: "RFQPTH01"
    	    , dataSource: dataSource3
    	    , timeGeometry: timeGeometry
    	    , valueGeometry: valueGeometry3
	    , lineColor: blue
	    //   	    , dotColor: green.lighten(30)
    	    , showValues: true	    
    	    , roundValues: false

    	})

 
    ];
    
    timeplot3 = Timeplot.create(document.getElementById("rfq-timeplot3"), plotInfo3);
    timeplot3.loadText(monitor3URL, ",", eventSource3);
    

    var valueGeometry4 = new Timeplot.DefaultValueGeometry({
        gridColor: gridColor
	, axisLabelsPlacement: "left"
    });
    
    
    var eventSource4 = new Timeplot.DefaultEventSource();
    var dataSource4  = new Timeplot.ColumnSource(eventSource4,1);
    var plotInfo4 = [
    	Timeplot.createPlotInfo
    	({
    	    id: "RFQPTH02"
    	    , dataSource: dataSource4
    	    , timeGeometry: timeGeometry
    	    , valueGeometry: valueGeometry4
	    , lineColor: azur
	    //   	    , dotColor: green.lighten(30)
    	    , showValues: true	    
    	    , roundValues: false

    	})

 
    ];
    
    timeplot4 = Timeplot.create(document.getElementById("rfq-timeplot4"), plotInfo4);
    timeplot4.loadText(monitor4URL, ",", eventSource4);

    
    var valueGeometry5 = new Timeplot.DefaultValueGeometry({
        gridColor: gridColor
    	, axisLabelsPlacement: "left"
    });
    
   
    var eventSource5 = new Timeplot.DefaultEventSource();
    var dataSource5  = new Timeplot.ColumnSource(eventSource5,1);
    var plotInfo5 = [
    	Timeplot.createPlotInfo
    	({
    	    id: "RFQLTH01"
    	    , dataSource: dataSource5
    	    , timeGeometry: timeGeometry
    	    , valueGeometry: valueGeometry5
	    , lineColor: orange
	    //   	    , dotColor: green.lighten(30)
    	    , showValues: true	    
    	    , roundValues: false

    	})

 
    ];
    
    timeplot5 = Timeplot.create(document.getElementById("rfq-timeplot5"), plotInfo5);
    timeplot5.loadText(monitor5URL, ",", eventSource5);
    
   
    
    
}


var resizeTimerID = null;
function onResize() {
    if (resizeTimerID == null) {
        resizeTimerID = window.setTimeout(function() {
            resizeTimerID = null;
            if (timeplot1) timeplot1.repaint();
	    if (timeplot2) timeplot2.repaint();
            if (timeplot3) timeplot3.repaint();
            if (timeplot4) timeplot4.repaint();
	    if (timeplot5) timeplot4.repaint();
         }, 0);
    }
}

