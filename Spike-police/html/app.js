var osCityhall = {}
var mouseOver = false;
var selectedIdentity = null;
var selectedIdentityType = null;
var selectedJob = null;
var selectedJobId = null;

osCityhall.Open = function(data) {
    $(".container").fadeIn(150);
}

osCityhall.Close = function() {
    $(".container").fadeOut(150, function(){
        osCityhall.ResetPages();
    });
    $.post('http://Spike-police/close');

    $(selectedJob).removeClass("job-selected");
    $(selectedIdentity).removeClass("job-selected");
}

osCityhall.ResetPages = function() {
    $(".cityhall-option-blocks").show();
    $(".cityhall-identity-page").hide();
    $(".cityhall-job-page").hide();
}

$(document).ready(function(){
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case "open":
                osCityhall.Open(event.data);
                break;
            case "close":
                osCityhall.Close();
                break;
        }
    })
});

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
            osCityhall.Close();
            break;
    }
});

$('.cityhall-option-block').click(function(e){
    e.preventDefault();

    var blockPage = $(this).data('page');

    $(".cityhall-option-blocks").fadeOut(100, function(){
        $(".cityhall-"+blockPage+"-page").fadeIn(100);
    });

    if (blockPage == "identity") {
        $(".identity-page-blocks").html("");
        $(".identity-page-blocks").html('<div class="identity-page-block" data-type="id-kaart" onmouseover="'+hoverDescription("id-card")+'" onmouseout="'+hoverDescription("id-card")+'"><p>BADGE</p></div>');
        $.post('http://Spike-police/requestLicenses', JSON.stringify({}), function(licenses){
            $.each(licenses, function(i, license){
                console.log(license.licenseType)
                var elem = '<div class="identity-page-block" data-type="'+license.idType+'" onmouseover="hoverDescription("'+license.idType+'")" onmouseout="hoverDescription("'+license.idType+'")"><p>'+license.label+'</p></div>';
                $(".identity-page-blocks").append(elem);
            });
        });
    }
});

hoverDescription = function(type) {
    if (!mouseOver) {
        if (type == "id-kaart") {
            $(".hover-description").fadeIn(10);
            $(".hover-description").html('<p>You are required to carry an Badge on you. <br>This is so that you can identify yourself at any time.</p>');
        } else if (type == "rijbewijs") {
            $(".hover-description").fadeIn(10);
            $(".hover-description").html('<p>MDT From Spike Industries for on feild processing.</p>');
        }
    } else {
        if(selectedIdentity == null) {
            $(".hover-description").fadeOut(10);
            $(".hover-description").html('');
        }
    }

    mouseOver = !mouseOver;
}

$(document).on("click", ".identity-page-block", function(e){
    e.preventDefault();

    var idType = $(this).data('type');

    selectedIdentityType = idType;

    if (selectedIdentity == null) {
        $(this).addClass("identity-selected");
        $(".hover-description").fadeIn(10);
        selectedIdentity = this;
        if (idType== "id-kaart") {
            $(".request-identity-button").fadeIn(100);
            $(".request-identity-button").html("<p>Request</p>")
        } else {
            $(".request-identity-button").fadeIn(100);
            $(".request-identity-button").html("<p>Request MDT Tablet</p>")
        }
    } else if (selectedIdentity == this) {
        $(this).removeClass("identity-selected");
        selectedIdentity = null;
        $(".request-identity-button").fadeOut(100);
    } else {
        $(selectedIdentity).removeClass("identity-selected");
        $(this).addClass("identity-selected");
        selectedIdentity = this;
        if($(this).data('type') == "id-kaart") {
            $(".request-identity-button").html("<p>Request Badge</p>")
        } else {
            $(".request-identity-button").html("<p>Request MDT Tablet</p>")
        }
    }
});

$(".request-identity-button").click(function(e){
    e.preventDefault();

    $.post('http://Spike-police/requestId', JSON.stringify({
        idType: selectedIdentityType
    }))

    osCityhall.ResetPages();
});

$(document).on("click", ".job-page-block", function(e){
    e.preventDefault();

    var job = $(this).data('job');

    selectedJobId = job;

    if (selectedJob == null) {
        $(this).addClass("job-selected");
        selectedJob = this;
        $(".apply-job-button").fadeIn(100);
    } else if (selectedJob == this) {
        $(this).removeClass("job-selected");
        selectedJob = null;
        $(".apply-job-button").fadeOut(100);
    } else {
        $(selectedJob).removeClass("job-selected");
        $(this).addClass("job-selected");
        selectedJob = this;
    }
});

$(document).on('click', '.apply-job-button', function(e){
    e.preventDefault();

    $.post('http://Spike-police/applyJob', JSON.stringify({
        job: selectedJobId
    }))

    osCityhall.ResetPages();
});

$(document).on('click', '.back-to-main', function(e){
    e.preventDefault();

    $(selectedJob).removeClass("job-selected");
    $(selectedIdentity).removeClass("job-selected");

    osCityhall.ResetPages();
});