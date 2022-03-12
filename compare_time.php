<?php

// Current 
$current_date = date("Y-m-d h:i:s", time());
// Show Current
echo "Current Date : " . $current_date . "<br/>";

// Will end at
// date
$end_at_date = "2016-12-15 10:03:30";
// second
$end_time_in_second = strtotime($end_at_date);
echo "End time in Date: " . $end_at_date . "<br/>";
echo "End time in second: " . $end_time_in_second . " (Second) <br/>";

/* 5 days in seconds */
$five_days = 5 * 24 * 60 * 60;


// Calculation
$rest_seconds = $end_time_in_second - time();
echo $five_days . "<br/>";
echo $rest_seconds . "<br/>";

if($rest_seconds < $five_days){  // If كفالة Ended time (in seconds) <= 5 days (in seconds) ---> echo Notification
    echo "Notification";
}else{
    echo "Empty";
}

?>
