// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets 
//= require turbolinks
//= require_tree .


  document.addEventListener('DOMContentLoaded', () => {
    const ordersContainer = document.getElementById('orders');
    const cartContainer = document.getElementById('cart-container');
    const cartButton = document.getElementById('cart-button');
  
    // Function to fetch updated order data from the server
    const fetchOrders = () => {
      fetch('/restaurants/<%= @restaurant.id %>/orders')
        .then(response => response.text())
        .then(html => {
          ordersContainer.innerHTML = html;
        })
        .catch(error => {
          console.error('Error fetching orders:', error);
        });
    };
  
    // Function to fetch and show the cart
    const showCart = () => {
      fetch('/restaurants/<%= @restaurant.id %>/cart')
        .then(response => response.text())
        .then(html => {
          cartContainer.innerHTML = html;
          cartContainer.style.display = 'block';
        })
        .catch(error => {
          console.error('Error fetching cart:', error);
        });
    };
  
    // Fetch orders on page load
    fetchOrders();
  
    // Set an interval to fetch orders periodically (e.g., every 10 seconds)
    setInterval(fetchOrders, 10000);
  
    // Show cart on cart button click
    cartButton.addEventListener('click', showCart);
  });


  document.addEventListener("DOMContentLoaded", function(event) {
    var stripe = Stripe('YOUR_STRIPE_PUBLISHABLE_KEY');
    var elements = stripe.elements();
    var cardElement = elements.create('card');

    cardElement.mount('#card-element');

    var cardErrors = document.getElementById('card-errors');
    var submitButton = document.getElementById('submit-button');

    cardElement.addEventListener('change', function(event) {
      if (event.error) {
        cardErrors.textContent = event.error.message;
      } else {
        cardErrors.textContent = '';
      }
    });

    var form = document.getElementById('payment-form');
    form.addEventListener('submit', function(event) {
      event.preventDefault();

      stripe.createToken(cardElement).then(function(result) {
        if (result.error) {
          cardErrors.textContent = result.error.message;
        } else {
          stripeTokenHandler(result.token);
        }
      });
    });

    function stripeTokenHandler(token) {
      var form = document.getElementById('payment-form');
      var hiddenInput = document.createElement('input');
      hiddenInput.setAttribute('type', 'hidden');
      hiddenInput.setAttribute('name', 'stripeToken');
      hiddenInput.setAttribute('value', token.id);
      form.appendChild(hiddenInput);

      form.submit();
    }
  });


  $(document).on('click', '#cart-icon', function() {
    $.ajax({
      url: '/restaurants/' + restaurantId + '/carts/show',
      method: 'GET',
      dataType: 'html',
      success: function(response) {
        $('#cartModal .modal-body').html(response);
      },
      error: function(xhr, status, error) {
        console.log(error);
      }
    });
  });


  $(document).ready(function() {
    $('.add-to-cart').on('click', function(e) {
      e.preventDefault();
  
      var url = $(this).attr('href');
  
      $.ajax({
        url: url,
        method: 'POST',
        dataType: 'json',
        success: function(response) {
          // Handle the success response
          // You can update the cart count or display a success message
        },
        error: function(xhr, status, error) {
          // Handle the error response
          // You can display an error message or handle the error as needed
        }
      });
    });
  });