window.addEventListener("message", function (event) {
  if (event.data.action == "open") {
    $("#carhud-main-container").css("display", "block");

    $(".fuel-prog").css("width", "0%");
    $(".motor-prog").css("width", "0%");

    setTimeout(function () {
      $("#carhud-main-container").css("opacity", "1");

      var fuelVal = event.data.fuel;
      var motorVal = event.data.engine / 10;
      $(".fuel-prog").css("width", fuelVal + "%");
      $(".motor-prog").css("width", motorVal + "%");

      $("#fueltext").text(Math.round(fuelVal));
      $("#motortext").text(Math.round(motorVal));
      $("#car-name").text("Car: " + event.data.carname);
      $("#plate-name").text("Plate: " + event.data.plate);
    }, 30);
  } else if (event.data.action == "close") {
    $("#carhud-main-container").css("display", "none");
  }
});

$(function () {
  //her menu acıldıgında olcak

  const digerMod = $("#diger-mod");
  digerMod.on("click", function () {
    $("#main2, #car-buttons-cont").fadeOut(100);

    $("#carhud-main-container").css("width", "35.5%");
    $("#carhud-main-container").css("height", "26.1%");

    $("#main1").css("width", "65vh");

    $(".buyuk-itemler").css("float", "left");
    $(".buyuk-itemler:first-child, .buyuk-itemler:nth-child(3)").css("margin-right", "1.3vh");

    $("#kucuk-item-container").css("width", "63.2vh");
    $(".kucuk-itemler").css("width", "48.9%");
    $(".kucuk-itemler:first-child, .kucuk-itemler:nth-child(3)").css("margin-right", "1.3vh");

    $("#onoff-button").css("top", "184%");
    $("#goback-button").css("display", "flex");
  });

  const maincont = $("#carhud-main-container");
  const goback = $("#goback-button");
  maincont.mouseenter(function () {
    if ($("#goback-button").css("display") != "none") {
      $("#goback-button").css("opacity", "1");
      setTimeout(function () {
        goback.animate(
          {
            top: "202%",
          },
          200
        );
      }, 20);
    }
  });

  maincont.mouseleave(function () {
    if ($("#goback-button").css("display") != "none") {
      goback.animate(
        {
          top: "250%",
        },
        250,
        function () {
          $("#goback-button").css("opacity", "0");
        }
      );
    }
  });

  goback.on("click", function () {
    $("#main2, #car-buttons-cont").fadeIn(100);

    $("#carhud-main-container").css("width", "55.4%");
    $("#carhud-main-container").css("height", "40.6%");

    $("#main1").css("width", "30.7vh");

    $(".buyuk-itemler").css("float", "left");
    $(".buyuk-itemler:first-child, .buyuk-itemler:nth-child(3)").css("margin-right", "0");

    $("#kucuk-item-container").css("width", "31vh");
    $(".kucuk-itemler").css("width", "48.35%");
    $(".kucuk-itemler:first-child, .kucuk-itemler:nth-child(3)").css("margin-right", "1vh");

    $("#onoff-button").css("top", "315%");
    $("#goback-button").css("display", "none");
    $("#goback-button").css("opacity", "0");
  });

  const kaputbagaj = $(".kaputbagaj");
  kaputbagaj.on("click", function () {
    kaputbagaj.filter(this).toggleClass("kaputbagaj-selected");
  });

  $("#interior").click(function () {
    $.post("https://oe-carmenu/interiorlight", JSON.stringify({}));
  });

  $("#vehdoorlock").click(function () {
    $.post("https://oe-carmenu/vehdoorlock", JSON.stringify({}));
  });

  $("#givecarkeys").click(function () {
    $.post("https://oe-carmenu/givecarkeys", JSON.stringify({}));
  });

  $("#onoff-button").click(function () {
    $.post("https://oe-carmenu/ignition", JSON.stringify({}));
  });

  $("#kaput").click(function () {
    $.post(
      "https://oe-carmenu/doors",
      JSON.stringify({
        door: 4,
      })
    );
  });
  $("#bagaj").click(function () {
    $.post(
      "https://oe-carmenu/doors",
      JSON.stringify({
        door: 5,
      })
    );
  });

  $("#window1").click(function () {
    //front left
    $.post(
      "https://oe-carmenu/windows",
      JSON.stringify({
        window: 0,
        door: 0,
      })
    );
    //$(this).toggleClass('circle-selected')
  });
  $("#window3").click(function () {
    //front right
    $.post(
      "https://oe-carmenu/windows",
      JSON.stringify({
        window: 1,
        door: 1,
      })
    );
    //$(this).toggleClass('circle-selected')
  });
  $("#window2").click(function () {
    //rear left
    $.post(
      "https://oe-carmenu/windows",
      JSON.stringify({
        window: 2,
        door: 2,
      })
    );
    //$(this).toggleClass('circle-selected')
  });
  $("#window4").click(function () {
    //rear right
    $.post(
      "https://oe-carmenu/windows",
      JSON.stringify({
        window: 3,
        door: 3,
      })
    );
    //$(this).toggleClass('circle-selected')
  });

  $("#kapi1").click(function () {
    $.post(
      "https://oe-carmenu/doors",
      JSON.stringify({
        door: 0,
      })
    );
  });
  $("#kapi3").click(function () {
    $.post(
      "https://oe-carmenu/doors",
      JSON.stringify({
        door: 1,
      })
    );
  });
  $("#kapi2").click(function () {
    $.post(
      "https://oe-carmenu/doors",
      JSON.stringify({
        door: 2,
      })
    );
  });
  $("#kapi4").click(function () {
    $.post(
      "https://oe-carmenu/doors",
      JSON.stringify({
        door: 3,
      })
    );
  });

  $("#koltuk1").click(function () {
    $.post(
      "https://oe-carmenu/seatchange",
      JSON.stringify({
        seat: -1,
      })
    );
  });
  $("#koltuk2").click(function () {
    $.post(
      "https://oe-carmenu/seatchange",
      JSON.stringify({
        seat: 0,
      })
    );
  });
  $("#koltuk4").click(function () {
    $.post(
      "https://oe-carmenu/seatchange",
      JSON.stringify({
        seat: 1,
      })
    );
  });
  $("#koltuk3").click(function () {
    $.post(
      "https://oe-carmenu/seatchange",
      JSON.stringify({
        seat: 2,
      })
    );
  });

  $(".kucuk-itemler:first-child").click(function () {
    $.post(
      "https://oe-carmenu/doors",
      JSON.stringify({
        door: 0,
      })
    );
    $.post(
      "https://oe-carmenu/doors",
      JSON.stringify({
        door: 1,
      })
    );
    $.post(
      "https://oe-carmenu/doors",
      JSON.stringify({
        door: 2,
      })
    );
    $.post(
      "https://oe-carmenu/doors",
      JSON.stringify({
        door: 3,
      })
    );
  });
});

document.onkeyup = function (data) {
  if (data.which == 27) {
    //esc
    $.post("https://oe-carmenu/exit", JSON.stringify({}));
    $("#carhud-main-container").css("display", "none");
  }
};

dragElement(document.getElementById("carhud-main-container"));

function dragElement(elmnt) {
  var pos1 = 0,
    pos2 = 0,
    pos3 = 0,
    pos4 = 0;
  if (document.getElementById(elmnt.id + "header")) {
    // if present, the header is where you move the DIV from:
    document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
  } else {
    // otherwise, move the DIV from anywhere inside the DIV:
    elmnt.onmousedown = dragMouseDown;
  }

  function dragMouseDown(e) {
    e = e || window.event;
    e.preventDefault();
    // get the mouse cursor position at startup:
    pos3 = e.clientX;
    pos4 = e.clientY;
    document.onmouseup = closeDragElement;
    // call a function whenever the cursor moves:
    document.onmousemove = elementDrag;
  }

  function elementDrag(e) {
    e = e || window.event;
    e.preventDefault();
    // calculate the new cursor position:
    pos1 = pos3 - e.clientX;
    pos2 = pos4 - e.clientY;
    pos3 = e.clientX;
    pos4 = e.clientY;
    // set the element's new position:
    elmnt.style.top = elmnt.offsetTop - pos2 + "px";
    elmnt.style.left = elmnt.offsetLeft - pos1 + "px";
  }

  function closeDragElement() {
    // stop moving when mouse button is released:
    document.onmouseup = null;
    document.onmousemove = null;
  }
}
