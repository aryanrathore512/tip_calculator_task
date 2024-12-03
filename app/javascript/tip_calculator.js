$(document).ready(function () {
  const billInput = $('#bill-amount');
  const customTipInput = $('.tip-btn.custom');
  const peopleInput = $('#people-count');
  const tipButtons = $('.tip-btn').not('.custom');
  const tipAmountDisplay = $('#tip-amount');
  const totalAmountDisplay = $('#total-amount');
  const resetButton = $('#reset');
  const errorDisplay = $('#error-display');

  let selectedTipPercentage = null;

  tipButtons.on('click', function () {
    selectedTipPercentage = parseFloat($(this).data('tip'));
    customTipInput.val('');
    tipButtons.removeClass('active');
    $(this).addClass('active');
    calculateTip();
  });

  customTipInput.on('input', function () {
    selectedTipPercentage = parseFloat($(this).val());
    tipButtons.removeClass('active');

    if (selectedTipPercentage < 1) {
      selectedTipPercentage = 1;
      customTipInput.val(1);
    }
    calculateTip();
  });

  const calculateTip = () => {
    const billAmount = parseFloat(billInput.val());
    const numberOfPeople = parseInt(peopleInput.val());

    $.ajax({
      url: '/calculations',
      type: 'POST',
      dataType: 'json',
      data: {
        calculation: {
          bill_amount: billAmount,
          tip_percentage: selectedTipPercentage,
          number_of_people: numberOfPeople
        }
      },
      success: function (data) {
        tipAmountDisplay.text(`$${data.tip_amount}`);
        totalAmountDisplay.text(`$${data.total_amount}`);
        errorDisplay.text('');
      },
      error: function (xhr) {
        const errors = xhr.responseJSON.errors || ['An error occurred'];
        errorDisplay.text(errors.join(', '));
      },
    });
  };

  billInput.add(peopleInput).on('blur', function () {
    const value = $(this).val();
    if (!value || parseFloat(value) <= 0) {
      errorDisplay.text('Please enter a valid value.');
    } else {
      errorDisplay.text('');
    }
  });

  billInput.add(customTipInput).add(peopleInput).on('change', calculateTip);

  resetButton.on('click', function () {
    billInput.val('');
    customTipInput.val('');
    peopleInput.val('');
    selectedTipPercentage = null;
    tipButtons.removeClass('active');
    tipAmountDisplay.text('$0.00');
    totalAmountDisplay.text('$0.00');
    errorDisplay.text('');
  });
});