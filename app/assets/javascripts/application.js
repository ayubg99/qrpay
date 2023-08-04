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

document.addEventListener("turbolinks:load", function() {
  $('body').on('click', '.add-to-cartt', function(e) {
    e.preventDefault();
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
        var existingCartItem = $('#cart-items').find(`[data-food-id="${response.cart_item_id}"]`);

        if (existingCartItem.length > 0) {
          // Update the quantity of the existing cart item
          var newQuantity = response.quantity;
          existingCartItem.find('.quantity').text('x ' + newQuantity);
          var newPrice = parseFloat(response.food_item.price * newQuantity).toFixed(2);
          existingCartItem.find('.price').text('€' + newPrice);
        } else {
          // Format the price with two decimal places
          var formattedPrice = parseFloat(response.food_item.price).toFixed(2);

          // Append the new cart item to the cart items list
          var cartItemHtml = `
            <div class="row cart_item" data-food-id="${response.cart_item_id}">
              <div class="col-6 col-sm-6 col-md-6">
                <h5>${response.food_item.name}</h5>
              </div>
              <div class="col-2 col-sm-2 col-md-2">
                <h5 class="quantity">x ${response.quantity}</h5>
              </div>
              <div class="col-2 col-sm-2 col-md-2 cart-buttons-wrapper">
                <a href="/restaurants/${response.restaurant_id}/cart/remove_from_cart/${response.cart_item.food_item_id}" class="btn btn-danger remove-cart-item" data-method="delete" data-remote="true">-</a>
                <a href="/restaurants/${response.restaurant_id}/cart/add_to_cart?food_item_id=${response.cart_item.food_item_id}" class="btn btn-primary add-to-cartt" data-remote="true">+</a>
              </div>
              <div class="col-2 col-sm-2 col-md-2">
                <h5 class="price">€${formattedPrice}</h5>
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


document.addEventListener("turbolinks:load", function() {
  // Function to handle the decrease quantity button click
  function handleDecreaseQuantityClick(event) {
    event.preventDefault();
    var removeUrl = $(this).attr('href');
  
    $.ajax({
      url: removeUrl,
      method: 'DELETE',
      dataType: 'json',
      success: function(response) {
        // Update cart item count dynamically
        var cartItemCount = parseInt($('#cart-item-count').text());
        $('#cart-item-count').text(Math.max(cartItemCount - 1, 0));
  
        // Find the cart item by its food item id
        var existingCartItem = $('#cart-items').find(`[data-food-id="${response.cart_item_id}"]`);
  
        // Update the quantity and price of the existing cart item
        if (existingCartItem.length > 0) {
          var newQuantity = response.quantity;
          existingCartItem.find('.quantity').text('x ' + newQuantity);
          if (newQuantity === 0) {
            existingCartItem.find('.price').text('€' + 0.00);
            existingCartItem.remove();
          } else {
            var newPrice = parseFloat(response.food_item.price * newQuantity).toFixed(2);
            existingCartItem.find('.price').text('€' + newPrice);
          }           
        }
        
        // Update cart total price
        var newTotalPrice = parseFloat(response.total_price).toFixed(2);
        $('#cart-total-price').text('Total: €' + newTotalPrice);
      },
      error: function(xhr, status, error) {
        console.log(error);
      }
    });
  }
  
  // Attach event listeners to all decrease quantity buttons
  $('body').on('click', '.remove-cart-item', handleDecreaseQuantityClick);
});


document.addEventListener("turbolinks:load", function() {
  // Function to handle the decrease quantity button click
  function handleDecreaseQuantityClick(event) {
    event.preventDefault();
    var removeUrl = $(this).attr('href');
  
    $.ajax({
      url: removeUrl,
      method: 'DELETE',
      dataType: 'json',
      success: function(response) {
        // Update cart item count dynamically
        var cartItemCount = parseInt($('#cart-item-count').text());
        $('#cart-item-count').text(Math.max(cartItemCount - 1, 0));
  
        // Find the cart item by its food item id
        var existingCartItem = $('#cart-items').find(`[data-menu-id="${response.cart_item_id}"]`);
  
        // Update the quantity and price of the existing cart item
        if (existingCartItem.length > 0) {
          var newQuantity = response.quantity;
          existingCartItem.find('.quantity').text('x ' + newQuantity);
          if (newQuantity === 0) {
            existingCartItem.find('.price').text('€' + 0.00);
            existingCartItem.remove();
          } else {
            var newPrice = parseFloat(response.special_menu.price * newQuantity).toFixed(2);
            existingCartItem.find('.price').text('€' + newPrice);
          }           
        }
        
        // Update cart total price
        var newTotalPrice = parseFloat(response.total_price).toFixed(2);
        $('#cart-total-price').text('Total: €' + newTotalPrice);
      },
      error: function(xhr, status, error) {
        console.log(error);
      }
    });
  }
  
  // Attach event listeners to all decrease quantity buttons
  $('body').on('click', '.remove_special_menu', handleDecreaseQuantityClick);
});


document.addEventListener("turbolinks:load", function() {
  // Add special menu to cart
  $('body').on('click', '.special-menu-cart-plus-link', function(e) {
    e.preventDefault();
    console.log('special-menu-cart-plus-link clicked!');

    var link = $(this);
    var url = link.attr('href');
    var menuId = link.data('menu-id');

    console.log('menuId:', menuId);


    $.ajax({
      url: url,
      method: 'POST',
      dataType: 'json',
      data: { menu_id: menuId },
      success: function(response) {
        // Update cart item count dynamically
        var cartItemCount = parseInt($('#cart-item-count').text());
        $('#cart-item-count').text(cartItemCount + 1);

        var existingCartItem = $('#cart-items').find(`[data-menu-id="${response.cart_item_id}"]`);
        console.log('Existing cart item:', existingCartItem);

          // Update the quantity of the existing cart item
          var newQuantity = response.quantity;
          existingCartItem.find('.quantity').text('x ' + newQuantity);
          console.log(existingCartItem.find('.quantity'));
          var newPrice = parseFloat(response.special_menu.price * newQuantity).toFixed(2);
          existingCartItem.find('.price').text('€' + newPrice);

        // Update cart total price
        var newTotalPrice = parseFloat(response.total_price).toFixed(2);
        $('#cart-total-price').text('Total: €' + newTotalPrice);
        console.log('AJAX response:', response);

      },
      error: function(xhr, status, error) {
        console.log(error);
      }
    });
  });
});

document.addEventListener("turbolinks:load", function() {
  // Special menu form submission
  $('body').on('submit', '.special-menu-form', function(e) {
    e.preventDefault();
    console.log('Form submitted!'); // Add this line to check if the event is triggered

    var form = $(this);
    var url = form.attr('action');
    var submitButton = form.find('input[type="submit"]');

    submitButton.prop('disabled', true);

    $.ajax({
      url: url,
      method: 'POST',
      dataType: 'json',
      data: form.serialize(),
      success: function(response) {
        console.log('AJAX response:', response);
        // Update cart item count dynamically
        var cartItemCount = parseInt($('#cart-item-count').text());
        $('#cart-item-count').text(cartItemCount + 1);


        // Check if the cart item already exists
        var existingCartItem = $('#cart-items').find(`[data-menu-id="${response.cart_item_id}"]`);

        if (existingCartItem.length > 0) {
          // Update the quantity of the existing cart item
          var newQuantity = response.quantity;
          existingCartItem.find('.quantity').text('x ' + newQuantity);
          var newPrice = parseFloat(response.special_menu.price * newQuantity).toFixed(2);
          existingCartItem.find('.price').text('€' + newPrice);
        
        } else {
        // Format the price with two decimal places
        var formattedPrice = parseFloat(response.special_menu.price).toFixed(2);
        console.log(response.food_items);
        // Build the cart item food items HTML
        var foodItemsHtml = '';
        response.food_items.forEach(function(food_item, index) {
          foodItemsHtml += food_item.name;
          if (index < response.food_items.length - 1) {
            foodItemsHtml += ', ';
          }
        });

        var specialMenuId = response.cart_item.special_menu_id;
        var foodItemIds = response.food_item_ids;
        console.log(foodItemIds);
        var restaurantId = response.restaurant_id;
        
        var linkUrl = '/restaurants/' + encodeURIComponent(restaurantId) + '/cart/add_to_cart?';
        
        // Append the food_item_ids to the linkUrl
        for (var i = 0; i < foodItemIds.length; i++) {
          if (i === 0) {
            linkUrl += 'food_item_ids[' + encodeURIComponent(foodItemIds[i]) + ']=' + encodeURIComponent(foodItemIds[i]);
          } else {
            linkUrl += '&food_item_ids[' + encodeURIComponent(foodItemIds[i]) + ']=' + encodeURIComponent(foodItemIds[i]);
          }
        }
        linkUrl += '&special_menu_id=' + encodeURIComponent(specialMenuId);
        
        // Replace square brackets encoding with %5B and %5D
        linkUrl = linkUrl.replace(/\[/g, '%5B').replace(/\]/g, '%5D');
        
        var cartItemLink = '<a href="' + linkUrl + '" class="btn btn-primary special-menu-cart-plus-link" data-remote="true" data-menu-id="' + response.cart_item_id + '">+</a>';
         console.log(cartItemLink);
        // Append the new cart item to the cart items list
        var cartItemHtml = `
          <div class="row cart_item" data-menu-id="${response.cart_item_id}">
            <div class="col-6 col-sm-6 col-md-6">
              <h5>${response.special_menu.name}</h5>
              <p style="font-weight: bold; font-size: 10px; color:rgb(128, 0, 255);">${foodItemsHtml}</p>
            </div>
            <div class="col-2 col-sm-2 col-md-2 cart-buttons-wrapper">
              <h5 class="quantity">x ${response.quantity}</h5>
            </div>
            <div class="col-2 col-sm-2 col-md-2 cart-buttons-wrapper">
            <a href="/restaurants/${response.restaurant_id}/cart/remove_special_menu/${response.cart_item_id}" class="btn btn-danger remove_special_menu" data-method="delete" data-remote="true">-</a>
            ${cartItemLink}
            </div>
            <div class="col-2 col-sm-2 col-md-2">
              <h5 class="price">€${formattedPrice}</h5>
            </div>
          </div>
        `;
        $('#cart-items').append(cartItemHtml);
        }
        // Update cart total price
        var newTotalPrice = parseFloat(response.total_price).toFixed(2);
        $('#cart-total-price').text('Total: €' + newTotalPrice);
        submitButton.prop('disabled', false); // Enable the button after the request is completed
      },
      error: function(xhr, status, error) {
        console.log(error);
      }
    });
  });
});

document.addEventListener("turbolinks:load", function() {
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


document.addEventListener("turbolinks:load", function() {
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



document.addEventListener("turbolinks:load", function() {
  const paymentOptions = document.querySelectorAll(".payment-option");

  paymentOptions.forEach(function (option) {
    option.addEventListener("click", function () {
      // Add the 'selected' class to the clicked option
      this.classList.add("selected");

      // Show the payment method selection modal
      $('#paymentMethodModal').modal('show');

      // Store the selected payment method in a hidden field
      const hiddenInput = document.querySelector("#order_payment_method");
      hiddenInput.value = this.getAttribute("data-method");
    });
  });

  // Handle the "Select" button click in the payment method modal
  document.getElementById("select-payment-method").addEventListener("click", function () {
    // Hide the payment method selection modal
    $('#paymentMethodModal').modal('hide');

    // Redirect to the order new page
    window.location.href = "/restaurants/" + restaurantId + "/orders/new";
  });
});