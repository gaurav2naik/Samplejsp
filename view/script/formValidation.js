/**
 * 
 */
function isValid(dateTime){
	var value = dateTime;
	// capture all the parts
	var matches = value.match(/^(\d{2})\-(\d{2})\-(\d{4}) (\d{2}):(\d{2}):(\d{2})$/);
	//alt:
	// value.match(/^(\d{2}).(\d{2}).(\d{4}).(\d{2}).(\d{2}).(\d{2})$/);
	// also matches 22/05/2013 11:23:22 and 22a0592013,11@23a22
	if (matches === null) {
		//alert("notValid")
	    return false;
	} else{
	    // now lets check the date sanity
	    var year = parseInt(matches[3], 10);
	    var month = parseInt(matches[2], 10) - 1; // months are 0-11
	    var day = parseInt(matches[1], 10);
	    var hour = parseInt(matches[4], 10);
	    var minute = parseInt(matches[5], 10);
	    var second = parseInt(matches[6], 10);
	    var date = new Date(year, month, day, hour, minute, second);
	    if (date.getFullYear() !== year
	      || date.getMonth() != month
	      || date.getDate() !== day
	      || date.getHours() !== hour
	      || date.getMinutes() !== minute
	      || date.getSeconds() !== second
	    ) {
	    //	alert("notValid");
	       return false;
	    } else {
	    //	alert("Valid");
	      return true;
	    }

	}
} 


function IsEmpty() {
	var StartTime=document.forms['form'].startTime.value;
	//alert(Date.format("dd-mm-yyyy hh:mm:ss"))
	var EndTime=document.forms['form'].endTime.value;
	
	if (document.forms['form'].startTime.value == "") {
		document.getElementById("error").innerHTML="Please enter Start Time";
		return false;
	}
	else if(!isValid(StartTime)){
		
		document.getElementById("error").innerHTML="Start Time is not valid";
		return false;
		
	}
	else if (document.forms['form'].endTime.value == "") {
		document.getElementById("error").innerHTML="Please enter End Time";
		return false;
	}
	else if (!isValid(EndTime)) {
		
		document.getElementById("error").innerHTML="End Time is not valid";
		return false;
		
	}
	else if(!isAfter(StartTime,EndTime)){
		document.getElementById("error").innerHTML="End Time should be less than Start Time";
		return false;
	}
	return true;

}

function isAfter(sDate,eDate){
	//alert("isAfter called");
	var StartDate=sDate;
	var EndDate=eDate;
	var a1=StartDate.split(" ");
	var a2=EndDate.split(" ");
	var d1=a1[0].split("-");
	var d2=a2[0].split("-");
	var t1=a1[1].split(":");
	var t2=a2[1].split(":");
	startdate= new Date(d1[2],(d1[1]-1),d1[0],t1[0],t1[1],t1[2]);
	enddate=new Date(d2[2],(d2[1]-1),d2[0],t2[0],t2[1],t2[2]);
	//alert(startdate);     //correct date
	//alert(enddate)
	startdate = startdate.getTime();
	enddate=enddate.getTime();
	//alert(startdate);
	//alert(enddate)
	if(startdate<enddate){
		return true;
	}
	else {
		return false;
	}
}




/*
function validate() {

    var format = 'yyyy-MM-dd';

    if(isAfterCurrentDate(document.getElementById('start').value, format)) {
        alert('Date is after the current date.');
    } else {
        alert('Date is not after the current date.');
    }
    if(isBeforeCurrentDate(document.getElementById('start').value, format)) {
        alert('Date is before current date.');
    } else {
        alert('Date is not before current date.');
    }
    if(isCurrentDate(document.getElementById('start').value, format)) {
        alert('Date is current date.');
    } else {
        alert('Date is not a current date.');
    }
    if (isBefore(document.getElementById('start').value, document.getElementById('end').value, format)) {
        alert('Start/Effective Date cannot be greater than End/Expiration Date');
    } else {
        alert('Valid dates...');
    }
    if (isAfter(document.getElementById('start').value, document.getElementById('end').value, format)) {
        alert('End/Expiration Date cannot be less than Start/Effective Date');
    } else {
        alert('Valid dates...');
    }
    if (isEquals(document.getElementById('start').value, document.getElementById('end').value, format)) {
        alert('Dates are equals...');
    } else {
        alert('Dates are not equals...');
    }
    if (isDate(document.getElementById('start').value, format)) {
        alert('Is valid date...');
    } else {
        alert('Is invalid date...');
    }
}

*//**
 * This method gets the year index from the supplied format
 *//*
function getYearIndex(format) {

    var tokens = splitDateFormat(format);

    if (tokens[0] === 'YYYY'
            || tokens[0] === 'yyyy') {
        return 0;
    } else if (tokens[1]=== 'YYYY'
            || tokens[1] === 'yyyy') {
        return 1;
    } else if (tokens[2] === 'YYYY'
            || tokens[2] === 'yyyy') {
        return 2;
    }
    // Returning the default value as -1
    return -1;
}

*//**
 * This method returns the year string located at the supplied index
 *//*
function getYear(date, index) {

    var tokens = splitDateFormat(date);
    return tokens[index];
}

*//**
 * This method gets the month index from the supplied format
 *//*
function getMonthIndex(format) {

    var tokens = splitDateFormat(format);

    if (tokens[0] === 'MM'
            || tokens[0] === 'mm') {
        return 0;
    } else if (tokens[1] === 'MM'
            || tokens[1] === 'mm') {
        return 1;
    } else if (tokens[2] === 'MM'
            || tokens[2] === 'mm') {
        return 2;
    }
    // Returning the default value as -1
    return -1;
}

*//**
 * This method returns the month string located at the supplied index
 *//*
function getMonth(date, index) {

    var tokens = splitDateFormat(date);
    return tokens[index];
}

*//**
 * This method gets the date index from the supplied format
 *//*
function getDateIndex(format) {

    var tokens = splitDateFormat(format);

    if (tokens[0] === 'DD'
            || tokens[0] === 'dd') {
        return 0;
    } else if (tokens[1] === 'DD'
            || tokens[1] === 'dd') {
        return 1;
    } else if (tokens[2] === 'DD'
            || tokens[2] === 'dd') {
        return 2;
    }
    // Returning the default value as -1
    return -1;
}

*//**
 * This method returns the date string located at the supplied index
 *//*
function getDate(date, index) {

    var tokens = splitDateFormat(date);
    return tokens[index];
}

*//**
 * This method returns true if date1 is before date2 else return false
 *//*
function isBefore(date1, date2, format) {
    // Validating if date1 date is greater than the date2 date
    if (new Date(getYear(date1, getYearIndex(format)), 
            getMonth(date1, getMonthIndex(format)) - 1, 
            getDate(date1, getDateIndex(format))).getTime()
        > new Date(getYear(date2, getYearIndex(format)), 
            getMonth(date2, getMonthIndex(format)) - 1, 
            getDate(date2, getDateIndex(format))).getTime()) {
        return true;
    } 
    return false;                
}

*//**
 * This method returns true if date1 is after date2 else return false
 *//*
function isAfter(date1, date2, format) {
    // Validating if date2 date is less than the date1 date
    if (new Date(getYear(date2, getYearIndex(format)), 
            getMonth(date2, getMonthIndex(format)) - 1, 
            getDate(date2, getDateIndex(format))).getTime()
        < new Date(getYear(date1, getYearIndex(format)), 
            getMonth(date1, getMonthIndex(format)) - 1, 
            getDate(date1, getDateIndex(format))).getTime()
        ) {
        return true;
    } 
    return false;                
}

*//**
 * This method returns true if date1 is equals to date2 else return false
 *//*
function isEquals(date1, date2, format) {
    // Validating if date1 date is equals to the date2 date
    if (new Date(getYear(date1, getYearIndex(format)), 
            getMonth(date1, getMonthIndex(format)) - 1, 
            getDate(date1, getDateIndex(format))).getTime()
        === new Date(getYear(date2, getYearIndex(format)), 
            getMonth(date2, getMonthIndex(format)) - 1, 
            getDate(date2, getDateIndex(format))).getTime()) {
        return true;
    } 
    return false;
}

*//**
 * This method validates and returns true if the supplied date is 
 * equals to the current date.
 *//*
function isCurrentDate(date, format) {
    // Validating if the supplied date is the current date
    if (new Date(getYear(date, getYearIndex(format)), 
            getMonth(date, getMonthIndex(format)) - 1, 
            getDate(date, getDateIndex(format))).getTime()
        === new Date(new Date().getFullYear(), 
                new Date().getMonth(), 
                new Date().getDate()).getTime()) {
        return true;
    } 
    return false;                
}

*//**
 * This method validates and returns true if the supplied date value 
 * is before the current date.
 *//*
function isBeforeCurrentDate(date, format) {
    // Validating if the supplied date is before the current date
    if (new Date(getYear(date, getYearIndex(format)), 
            getMonth(date, getMonthIndex(format)) - 1, 
            getDate(date, getDateIndex(format))).getTime()
        < new Date(new Date().getFullYear(), 
                new Date().getMonth(), 
                new Date().getDate()).getTime()) {
        return true;
    } 
    return false;                
}

*//**
 * This method validates and returns true if the supplied date value 
 * is after the current date.
 *//*
function isAfterCurrentDate(date, format) {
    // Validating if the supplied date is before the current date
    if (new Date(getYear(date, getYearIndex(format)), 
            getMonth(date, getMonthIndex(format)) - 1, 
            getDate(date, getDateIndex(format))).getTime()
        > new Date(new Date().getFullYear(),
                new Date().getMonth(), 
                new Date().getDate()).getTime()) {
        return true;
    } 
    return false;                
}

*//**
 * This method splits the supplied date OR format based 
 * on non alpha numeric characters in the supplied string.
 *//*
function splitDateFormat(dateFormat) {
    // Spliting the supplied string based on non characters
    return dateFormat.split(/\W/);
}


 * This method validates if the supplied value is a valid date.
 
function isDate(date, format) {                
    // Validating if the supplied date string is valid and not a NaN (Not a Number)
    if (!isNaN(new Date(getYear(date, getYearIndex(format)), 
            getMonth(date, getMonthIndex(format)) - 1, 
            getDate(date, getDateIndex(format))))) {                    
        return true;
    } 
    return false;                                      
}
*/
