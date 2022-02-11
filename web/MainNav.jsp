<html>
    <body>
        <style>
            .brand-logo{
                display: flex;
                align-items: center;
            }
            .main-nav ul{
                display:flex;
                margin: 0;
                padding: 0;
                list-style: none;
            }
            .main-nav a{
                color:#5e5e5e;
                text-decoration: none;
                font-weight: bold;
                padding: 20px;
            }
            .main-nav a:hover{
                color: orangered;
            }
            .main-header{
                display: flex;
                justify-content: space-between;
                align-items: center;
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 40px 10px;
            }
            .main-header img{
                height:90px;
            }
        </style>
	<header class="main-header">
            <a href="/" class="brand-logo">
                <img src="images/logoRamly.png">
            </a>
            <nav class="main-nav">
		<ul>
                    <li><a href="Main.jsp">
			<span class="fa fa-home" aria-hidden="true"></span> Home </a>
                    </li>
                    <li><a href="ItemController?action=mainCatalogue">
			<span class="fa fa-shopping-bag" aria-hidden="true"></span> Our Products </a>
                    </li>
                    <li><a href="MainLogin.jsp">
			<span class="fa fa-unlock-alt" aria-hidden="true"></span> Login </a>
                    </li>
		</ul>
            </nav>
	</header>
    </body>
</html>