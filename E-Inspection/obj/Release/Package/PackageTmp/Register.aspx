<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="E_Inspection.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<!-- Meta tag Keywords -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta charset="UTF-8" />
	<meta name="keywords" content="Freight Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
	<script>
		addEventListener("load", function () {
			setTimeout(hideURLbar, 0);
		}, false);

		function hideURLbar() {
			window.scrollTo(0, 1);
		}
	</script>
	<!-- //Meta tag Keywords -->

	<!-- Custom-Files -->
	<link rel="stylesheet" href="css/bootstrap.css">
	<!-- Bootstrap-Core-CSS -->
	<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
	<!-- Style-CSS -->
	<link href="css/font-awesome.min.css" rel="stylesheet">
	<!-- Font-Awesome-Icons-CSS -->
	<!-- //Custom-Files -->

	<!-- Web-Fonts -->
	<link href="//fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i"
	 rel="stylesheet">
	<link href="//fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900,900i" rel="stylesheet">
	<!-- //Web-Fonts -->
    <link href="css/sweetalert.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/sweetalerthtml.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var password = document.getElementById("password1"), confirm_password = document.getElementById("password2");

            function validatePassword() {
                if (password.value != confirm_password.value) {
                    confirm_password.setCustomValidity("Passwords Don't Match");
                } else {
                    confirm_password.setCustomValidity('');
                }
            }
            password.onchange = validatePassword;
            confirm_password.onkeyup = validatePassword;
        });
        function successalert() {
            var msginfo = " <div>Thank you for registering.</div>"
            Swal.fire({
                title: "Registration",
                html: msginfo,
                confirmButtonText: "OK",
            }).then(function () {
                location.href = "Login.aspx";
            });
        }
    </script>
</head>
<body>
    <div>
        <!-- header -->
	<header id="home">
		<div class="container">
			<div class="header d-lg-flex justify-content-between align-items-center py-sm-3 py-2 px-sm-2 px-1">
				<!-- logo -->
				<div id="logo">
					<h1><a href="index.html">E-Inspection</a></h1>
				</div>
				<!-- //logo -->
				<!-- nav -->
				<div class="nav_w3ls ml-lg-5">
					<nav>
						<label for="drop" class="toggle">Menu</label>
						<input type="checkbox" id="drop" />
						<ul class="menu">
							<li><a href="index.html">Home</a></li>
							<li><a href="about.html">About Us</a></li>
							<li><a href="portfolio.html">Portfolio</a></li>
							<li class="hide">
								<!-- First Tier Drop Down -->
								<label for="drop-2" class="toggle toogle-2">Dropdown <span class="fa fa-angle-down" aria-hidden="true"></span>
								</label>
								<a href="#">Dropdown <span class="fa fa-angle-down" aria-hidden="true"></span></a>
								<input type="checkbox" id="drop-2" />
								<ul>
									<li><a href="index.html" class="drop-text">Blog</a></li>
									<li><a href="single.html" class="drop-text">Single Page</a></li>
									<li><a href="index.html" class="drop-text">Services</a></li>
									<li><a href="about.html" class="drop-text">More</a></li>
								</ul>
							</li>
							<li><a href="contact.html">Contact Us</a></li>
							<li class="ml-xl-5 ml-lg-2 mt-lg-0 mt-sm-4 mt-3">
								<a href="Login.aspx" class="reqe-button">Login</a>
								<a href="Register.aspx" class="reqe-button">Register</a>
							</li>
						</ul>
					</nav>
				</div>
				<!-- //nav -->
			</div>
		</div>
	</header>
	<!-- //header -->
	<!-- inner banner -->
	<div class="inner-banner-w3ls d-flex flex-column justify-content-center align-items-center">
	</div>
	<!-- //inner banner -->
	<!-- breadcrumbs -->
	<nav aria-label="breadcrumb">
		<ol class="breadcrumb d-flex justify-content-center">
			<li class="breadcrumb-item">
				<a href="index.html">Home</a>
			</li>
			<li class="breadcrumb-item active" aria-current="page">Register</li>
		</ol>
	</nav>
	<!-- //breadcrumbs -->

	<!-- register  -->
	<div class="modal-body align-w3">
		<form class="p-sm-3" runat="server">
            <div class="form-group">
                    <label for="ddlUser">User Type</label>                    
                    <select class="form-control" id="ddlUser" runat="server" required="required">                                          
                    </select>
            </div>
			<div class="form-group">
				<label for="recipient-name" class="col-form-label">Username</label>
				<input type="text" class="form-control" placeholder="your name" name="Name" runat="server" id="txtUserName" required="required">
			</div>
			<div class="form-group">
				<label for="recipient-email" class="col-form-label">Email</label>
				<input type="email" class="form-control" placeholder="XXXXX@XX.com" name="Email" runat="server" id="txtEmail"
				 required="">
			</div>
			<div class="form-group">
				<label for="password1" class="col-form-label">Password</label>
				<input type="password" class="form-control" placeholder="******" name="Password" runat="server" id="password1" required="required">
			</div>
			<div class="form-group">
				<label for="password2" class="col-form-label">Confirm Password</label>
				<input type="password" class="form-control" placeholder="******" name="Confirm Password" id="password2" required="required">
			</div>			
			<div class="right-w3l">	
                 <label class="col-form-label text-danger" id="lblerror" runat="server"></label>			
                <asp:Button  class="form-control bg-theme" Text="Register" ID="btnRegister" runat="server" OnClick="btnRegister_Click" />
			</div>
		</form>
	</div>
	<!-- //register -->

	<!-- footer -->
	<footer class="footer py-md-5 pt-md-3 pb-sm-5">
		<div class="container">
			<div class="row p-sm-4 px-3 py-3">
				<div class="col-lg-4 footer-top mt-md-0 mt-sm-5">
					<h2>
						<a class="navbar-brand" href="index.html">
							Freight
						</a>
					</h2>
					<div class="fv3-contact mt-2">
						<p>
							<a href="mailto:example@email.com">info@example.com</a>
						</p>
					</div>
					<div class="fv3-contact my-2">
						<p>+456 123 7890</p>
					</div>
					<div class="fv3-contact">
						<p>+90 nsequursu dsdesdc,
							<br>xxx Street State 34789.</p>
					</div>
				</div>
				<div class="col-lg-2  col-md-6 mt-lg-0 mt-4">
					<div class="footerv2-w3ls">
						<h3 class="mb-3 w3f_title">Navigation</h3>
						<hr>
						<ul class="list-w3pvtits">
							<li>
								<a href="index.html">
									Home
								</a>
							</li>
							<li class="my-2">
								<a href="about.html">
									About Us
								</a>
							</li>
							<li class="my-2">
								<a href="portfolio.html">
									Portfolio
								</a>
							</li>
							<li class="mb-2">
								<a href="single.html">
									Blog
								</a>
							</li>
							<li>
								<a href="contact.html">
									Contact Us
								</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="col-lg-2  col-md-6 mt-lg-0 mt-4">
					<div class="footerv2-w3ls">
						<h3 class="mb-3 w3f_title">Links</h3>
						<hr>
						<ul class="list-w3pvtits">
							<li>
								<a href="about.html">
									Our Mission
								</a>
							</li>
							<li class="my-2">
								<a href="single.html">
									Latest posts
								</a>
							</li>
							<li class="my-2">
								<a href="portfolio.html">
									Explore
								</a>
							</li>
							<li class="mb-2">
								<a href="contact.html">
									Find us
								</a>
							</li>
							<li>
								<a href="index.html">
									Privacy Policy
								</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="col-lg-2 col-md-6 mt-lg-0 mt-4">
					<div class="footerv2-w3ls">
						<h3 class="mb-3 w3f_title">Links</h3>
						<hr>
						<ul class="list-w3pvtits">
							<li>
								<a href="single.html">
									more
								</a>
							</li>
							<li class="my-2">
								<a href="portfolio.html">
									our work
								</a>
							</li>
							<li class="my-2">
								<a href="about.html">
									Explore
								</a>
							</li>
							<li class="mb-2">
								<a href="contact.html">
									contact us
								</a>
							</li>
							<li>
								<a href="index.html">
									references
								</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="col-lg-2  col-md-6 mt-lg-0 mt-4">
					<div class="footerv2-w3ls">
						<h3 class="mb-3 w3f_title">Links</h3>
						<hr>
						<ul class="list-w3pvtits">
							<li class="my-2">
								<a href="portfolio.html">
									Explore
								</a>
							</li>
							<li>
								<a href="about.html">
									Our Mission
								</a>
							</li>
							<li class="my-2">
								<a href="single.html">
									Latest posts
								</a>
							</li>

							<li class="mb-2">
								<a href="contact.html">
									Find us
								</a>
							</li>
							<li>
								<a href="index.html">
									Privacy Policy
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- //footer bottom -->
	</footer>
	<!-- //footer -->
	<!-- copyright -->
	<div class="cpy-right text-center bg-theme">
		<p class="text-wh">© 2019 Freight. All rights reserved | Design by
			<a href="http://w3layouts.com"> W3layouts.</a>
		</p>
	</div>
	<!-- //copyright -->
	<!-- move top icon -->
	<a href="#home" class="move-top text-center">
		<span class="fa fa-level-up" aria-hidden="true"></span>
	</a>
	<!-- //move top icon -->
    </div>
</body>
</html>
