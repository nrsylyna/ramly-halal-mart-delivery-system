<html>
    <body>
        <style>
            .brand-logo {
                display: flex;
                align-items: center;
            }
            .main-nav ul {
                display:flex;
                margin: 0;
                padding: 0;
                list-style: none;
            }
            .main-nav a {
                color:#5e5e5e;
                text-decoration: none;
                font-weight: bold;
                padding: 20px;
            }
            .main-nav a:hover {
                color: orangered;
            }
            .main-header {
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
            <a href="index.html">
                <img src="images/logoRamly.png">
            </a>
            <nav class="main-nav">
                <ul>
                    <li>
                        <a href="HomepageRider.jsp">
                        <span class="fa fa-home" aria-hidden="true"></span> Home </a>
                    </li>
                    <li>
                        <a href="ManageRiderStatus.jsp">
                        <span class="fa fa-pencil-square-o" aria-hidden="true"></span> Manage Status </a>
                    </li>
                    <li>
                        <a href="<%=request.getContextPath()%>/OrderController?action=listOrderRider&id=<%=rider.getRiderID() %>">
                        <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span> Customer Order </a>
                    </li>
                    <li>
                        <a href="ProfileRider.jsp">
                        <span class="fa fa-user-circle-o" aria-hidden="true"></span> Profile </a>
                    </li>
                    <li>
                        <a  href="<%=request.getContextPath()%>/LogoutController?action=logoutRider">
                        <span class="fa fa-lock" aria-hidden="true"></span> Log Out </a>
                    </li>
                </ul>
            </nav>
        </header>
    </body>
</html>