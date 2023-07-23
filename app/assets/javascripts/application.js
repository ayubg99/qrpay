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
//= require highcharts/highcharts
//= require highcharts/highcharts-more
//= require highcharts/highstock
//= require_tree .


document.addEventListener('turbolinks:load', function() {
  $('.add-to-cartt').on('click', function() {
    var url = $(this).attr('href');

    $.ajax({
      url: url,
      method: 'POST',
      dataType: 'json',
      success: function(response) {
        // Update cart item count dynamically
        var cartItemCount = parseInt($('#cart-item-count').text());
        $('#cart-item-count').text(cartItemCount + 1);

        // Check if the cart item already exists
        var existingCartItem = $('#cart-items').find(`[data-food-id="${response.cart_item.food_item_id}"]`);

        if (existingCartItem.length > 0) {
          // Update the quantity of the existing cart item
          var newQuantity = response.quantity;
          existingCartItem.find('.quantity').text('x ' + newQuantity);
          var newPrice = parseFloat(response.food_item.price * newQuantity).toFixed(2);
          existingCartItem.find('.price').text(newPrice);
        } else {
          // Format the price with two decimal places
          var formattedPrice = parseFloat(response.food_item.price).toFixed(2);

          // Append the new cart item to the cart items list
          var cartItemHtml = `
            <div class="row cart_item" data-food-id="${response.cart_item.food_item_id}">
              <div class="col-8 col-sm-8 col-md-8">
                <h6>${response.food_item.name}</h6>
              </div>
              <div class="col-2 col-sm-2 col-md-2">
                <h6 class="quantity">x ${response.quantity}</h6>
              </div>
              <div class="col-2 col-sm-2 col-md-2">
                <h6 class="price">€${formattedPrice}</h6>
              </div>
            </div>
          `;
          $('#cart-items').append(cartItemHtml);
        }

        // Update cart total price
        var newTotalPrice = parseFloat(response.total_price).toFixed(2);
        $('#cart-total-price').text('Total: €' + newTotalPrice);
      },
      error: function(xhr, status, error) {
        console.log(error);
      }
    });
  });
});

document.addEventListener('turbolinks:load', function() {
  // Special menu form submission
  $(document).on('submit', '.special-menu-form', function(e) {
    e.preventDefault();
    var form = $(this);
    var url = form.attr('action');

    $.ajax({
      url: url,
      method: 'POST',
      dataType: 'json',
      data: form.serialize(),
      success: function(response) {
        // Update cart item count dynamically
        var cartItemCount = parseInt($('#cart-item-count').text());
        $('#cart-item-count').text(cartItemCount + 1);

        // Format the price with two decimal places
        var formattedPrice = parseFloat(response.special_menu.price).toFixed(2);
        console.log(response);

        // Build the cart item food items HTML
        var foodItemsHtml = '';
        response.food_items.forEach(function(food_item, index) {
          foodItemsHtml += food_item.name;
          if (index < response.food_items.length - 1) {
            foodItemsHtml += ', ';
          }
        });

        // Append the new cart item to the cart items list
        var cartItemHtml = `
          <div class="row cart_item">
            <div class="col-8 col-sm-8 col-md-8">
              <h6>${response.special_menu.name}</h6>
              <p style="font-size: 10px; color:rgb(128, 0, 255);">${foodItemsHtml}</p>
            </div>
            <div class="col-2 col-sm-2 col-md-2">
                <h6>x ${response.quantity}</h6>
            </div>
            <div class="col-2 col-sm-2 col-md-2">
              <h6>€${formattedPrice}</h6>
            </div>
          </div>
        `;
        $('#cart-items').append(cartItemHtml);

        // Update cart total price
        var newTotalPrice = parseFloat(response.total_price).toFixed(2);
        $('#cart-total-price').text('Total: €' + newTotalPrice);
      },
      error: function(xhr, status, error) {
        console.log(error);
      }
    });
  });
});

document.addEventListener('turbolinks:load', function() {
  const stripe = Stripe('pk_test_51NS2OyIULic551znN5qUeq7168Gyt9bka1OWGD4jmbI8MkfJSy9axar3uiwSMoOTipm9lclj9eWqI7iRl7mEeufe000lH5hnuT'); // Replace with your own test publishable key
  const elements = stripe.elements();
  const cardElement = elements.create('card');

  cardElement.mount('#card-element');

  const form = document.getElementById('stripe-payment-form');
  const errorElement = document.getElementById('card-errors');
  const submitButton = document.getElementById('submit-order');
  const paymentForm = document.getElementById('payment-form');
  const totalAmount = paymentForm.dataset.totalAmount;
  const clientSecret = form.dataset.clientSecret.toString();
  console.log(clientSecret);

  form.addEventListener('submit', async (event) => {
    event.preventDefault();

    // Disable the submit button to prevent multiple clicks
    submitButton.disabled = true;

    if (cardElement._empty) {
      // Display an error message or handle the validation error
      errorElement.textContent = 'Please enter payment information.';
      submitButton.disabled = false; // Re-enable the submit button
      return;
    }

    try {
      const { paymentIntent, error } = await stripe.confirmCardPayment(
        clientSecret,
        {
          payment_method: {
            card: cardElement,
          },
        }
      );

      if (error) {
        // Display error message
        errorElement.textContent = error.message;
      } else {
        // Set the value of the hidden field to the payment method ID
        const paymentIntentInput = document.createElement('input');
        paymentIntentInput.setAttribute('type', 'hidden');
        paymentIntentInput.setAttribute('name', 'payment_intent_id');
        paymentIntentInput.value = paymentIntent.id;
        form.appendChild(paymentIntentInput);

        // Submit the form using AJAX
        const formData = new FormData(form);
        const response = await fetch(form.action, {
          method: form.method,
          body: formData
        });

        if (response.ok) {
          // Success, handle the response or redirect as needed
        } else {
          // Handle errors or display error message
        }
      }
    } catch (error) {
      // Display error message
      errorElement.textContent = error.message;
    } finally {
      // Re-enable the submit button
      submitButton.disabled = false;
    }
  });
});


document.addEventListener('turbolinks:load', function() {
  const body = document.querySelector('body');
  const sidebar = body.querySelector('nav');
  const toggle = body.querySelector('.toggle');
  const modeSwitch = body.querySelector('.toggle-switch');
  const modeText = body.querySelector('.mode-text');

  // Function to toggle dark mode
  function toggleDarkMode() {
    body.classList.toggle('dark');
    if (body.classList.contains('dark')) {
      modeText.innerText = 'Light mode';
      // Store dark mode preference in local storage
      localStorage.setItem('darkMode', 'true');
    } else {
      modeText.innerText = 'Dark mode';
      // Remove dark mode preference from local storage
      localStorage.removeItem('darkMode');
    }
  }

  toggle.addEventListener("click" , () =>{
    sidebar.classList.toggle("close");
  })

  modeSwitch.addEventListener('click', toggleDarkMode);

  // Check for dark mode preference on page load
  const darkModePreference = localStorage.getItem('darkMode');
  if (darkModePreference === 'true') {
    body.classList.add('dark');
    modeText.innerText = 'Light mode';
  }
});