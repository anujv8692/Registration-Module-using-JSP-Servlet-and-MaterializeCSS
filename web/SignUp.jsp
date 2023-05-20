<%-- 
    Document   : SignUp
    Created on : 17-Apr-2023, 5:56:20 pm
    Author     : anujv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Signup Page</title>
        <!-- Compiled and minified CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

        <!-- Compiled and minified JavaScript -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

        <!--jquery cdn-->
        <script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>
    </head>
    <body style="background: url(Images/a.jpg ); background-size:cover; background-attachment: fixed" >
        <!--<img src="Images/a.jpg" alt=""/>-->


        <div class="container" style="margin-top: 8%">
            <div class="row">
                <div class="col s6 offset-s3">
                    <div class="card">
                        <div class="card-content">
                            <h3 class="center-align">Register Here</h3>
                            <h5 id="msg" class="center-align"></h5>
                            <div class="form center-align">
                                <form action="Register" id="myform">
                                    <input placeholder="Enter Your Name" name="name" id="name" type="text" class="validate" required>
                                    <input placeholder="Enter Your Email" name="email" id="email" type="email" class="validate" required>
                                    <input placeholder="Enter Your Password" name="password" id="password" type="password" class="validate" required>
                                    <!--file upload-->
                                    <div class="file-field input-field">
                                        <div class="btn #512da8 deep-purple darken-2">
                                            <span>File</span>
                                            <input type="file" name="pic" accept="image/png, image/gif, image/jpeg" required>
                                        </div>
                                        <div class="file-path-wrapper">
                                            <input class="file-path validate" type="text" id="filepath">
                                        </div>
                                    </div>
                                    <button type="submit" class="btn waves-effect waves-light purple">SignUp</button>
                                </form>
                            </div>
                            <div class="loader center-align" style="margin-top: 10px; display: none";>
                                <div class="preloader-wrapper big active">
                                    <div class="spinner-layer spinner-blue-only">
                                        <div class="circle-clipper left">
                                            <div class="circle"></div>
                                        </div>
                                        <div class="gap-patch">
                                            <div class="circle"></div>
                                        </div>
                                        <div class="circle-clipper right">
                                            <div class="circle"></div>
                                        </div>
                                    </div>
                                </div>
                                <h5>Please Wait...</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            $(document).ready(function () {

                $("#myform").on('submit', function (event) {
                    event.preventDefault();

                    let formdata = new FormData(this);

                    $(".loader").show();
                    $(".form").hide();

                    $.ajax({
                        url: "Register",
                        data: formdata,
                        type: 'POST',
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            $(".loader").hide();
                            $(".form").show();
//                           console.log(data.trim());
                            if (data.trim() === 'done') {
                                $("#msg").html("Successfully Registerd !!");
                                $("#msg").addClass('green-text');
                                $("#myform")[0].reset(); //to clearalll fields
//                                
                            } else {
                                $("#msg").html("Something went wrong !!");
                                $("#msg").addClass('red-text');
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(data);
                            alert("Error");
                            $("#msg").html("Something went wrong !!");
                            $(".loader").hide();
                            $(".form").show();
                        },
                        processData: false,
                        contentType: false


                    });
                });

            });
        </script>


    </body>
</html>
