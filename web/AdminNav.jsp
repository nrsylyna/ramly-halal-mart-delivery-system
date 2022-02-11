<html>
  <body>
    <style>
      .brand-logo {
        display: flex;
        align-items: center;
      }
      .main-nav ul {
        display: flex;
        margin: 0;
        padding: 0;
        list-style: none;
      }
      .main-nav a {
        color: #5e5e5e;
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
      .main-header img {
        height: 90px;
      }
    </style>
    <header class="main-header">
      <a href="/" class="brand-logo">
        <img src="images/logoRamly.png" />
      </a>
      <nav class="main-nav">
        <ul>
          <li>
            <a href="HomepageAdmin.jsp">
              <span class="fa fa-home" aria-hidden="true"></span> Home
            </a>
          </li>
          <li>
            <a href="ItemController?action=catalogue">
              <span class="fa fa-cart-arrow-down" aria-hidden="true"></span>
              Manage Item
            </a>
          </li>
          <li>
            <a href="OrderController?action=listOrderAdmin">
              <span
                class="glyphicon glyphicon-shopping-cart"
                aria-hidden="true"
              ></span>
              Order
            </a>
          </li>
          <li>
            <a href="PaymentController?action=listPayment">
              <span class="fa fa-pencil-square-o" aria-hidden="true"></span>
              Payment Status
            </a>
          </li>
          <li>
            <a href="AssignRiderController?action=listRider">
              <span class="fa fa-motorcycle" aria-hidden="true"></span> Assign
              Rider
            </a>
          </li>
          <li>
            <a href="Report.jsp">
              <span class="fa fa-clipboard" aria-hidden="true"></span> Report
            </a>
          </li>
          <li>
            <a href="LogoutController?action=logoutAdmin">
              <span class="fa fa-lock" aria-hidden="true"></span> Log Out
            </a>
          </li>
        </ul>
      </nav>
    </header>
  </body>
</html>
