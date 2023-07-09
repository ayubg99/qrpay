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


$(document).ready(function() {
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

        // Format the price with two decimal places
        var formattedPrice = parseFloat(response.food_item.price).toFixed(2);

        // Append the new cart item to the cart items list
        var cartItemHtml = `
          <div class="row cart_item">
            <div class="col-8 col-sm-8 col-md-8">
              <h6>${response.food_item.name}</h6>
            </div>
            <div class="col-4 col-sm-4 col-md-4">
              <h6>€${formattedPrice} <a href="${response.remove_url}" data-method="delete" class="btn remove-from-cart-link">x</a></h6>
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
            <div class="col-4 col-sm-4 col-md-4">
              <h6>€${formattedPrice} <a href="${response.remove_url}" data-method="delete" class="btn remove-from-cart-link" remote="true">x</a></h6>
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

  $('.remove-from-cart-link').on('click', function(e) {
    e.preventDefault();
    var url = $(this).attr('href');
    var cartItemElement = $(this).closest('.cart-item');

    $.ajax({
      url: url,
      method: 'DELETE',
      dataType: 'json',
      success: function(response) {
        // Remove the cart item from the DOM
        cartItemElement.remove();

        // Update cart item count dynamically
        var cartItemCount = parseInt($('#cart-item-count').text());
        $('#cart-item-count').text(cartItemCount - 1);

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

