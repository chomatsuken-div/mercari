$(document).on('turbolinks:load', function() {
  var form = $("charge-form");
    number = form.find('input[name="number"]'),
    cvc = form.find('input[name="cvc"]'),
    exp_month = form.find('input[name="exp_month"]'),
    exp_year = form.find('input[name="exp_year"]');

// カード情報の登録が押された瞬間にフォームに入っている値を取得し、cardという変数にハッシュ型で代入しています。
  $("#charge-form").on("click", "#card-save", function(e) {
    e.preventDefault();
    form.find("input[type=submit]").prop("disabled", true);
    var card = {
        number: $("#payment_card_no").val(),
        cvc: $("#payment_card_security_code").val(),
        exp_month: $("#payment_card_expire_mm").val(),
        exp_year: $("#payment_card_expire_yy").val()
    };

// Payjp.createTokenはpay.jp側で指定されたメソッドでこちらでトークンの作成を行なっています。
    Payjp.createToken(card, function(s, response) {

      if (response.error) {
        alert("error")
        form.find('button').prop('disabled', false);
      }
      else {
        $(".number").removeAttr("name");
        $(".cvc").removeAttr("name");
        $(".exp_month").removeAttr("name");
        $(".exp_year").removeAttr("name");

// hiddenでappendすることにより見た目の変更をせずにtokenをparamsに入れることにしています。こちらを加える理由は後ほど作成する顧客IDで使用するためです。
        var token = response.id;
        $("#charge-form").append(`<input type="hidden" name="pay_id" class="payjp-token" value=${token} />`)
        $("#charge-form").get(0).submit();
      }
    });
  });
  });