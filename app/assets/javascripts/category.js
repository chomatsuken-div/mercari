$(document).on('turbolinks:load', function(){

    var category_search = $(".productForm__field--category");

    function appendChildSelect(child) {
      var html =
          `<div class="select-wrap" id="child-wrap">
            <select class="inputField inputField__select" id="child-category" name="product[category_id]">
                <option value>---</option>
            </select>
          </div>`
      category_search.append(html)
    }

function appendGrandChildSelect(grandchild) {
    var html =
        `<div class="select-wrap" id="grandchild-wrap">
          <select class="inputField inputField__select" id="grandchild-category" name="product[category_id]">
              <option value>---</option>
          </select>
        </div>`
    category_search.append(html)
  }


function appendChild(child) {
  $("#child-category").append(
    $("<option>")
      .val($(child).attr('id'))
      .text($(child).attr('name'))
  )
}


function appendGrandChild(grandchild) {
  $("#grandchild-category").append(
    $("<option>")
      .val($(grandchild).attr('id'))
      .text($(grandchild).attr('name'))
  )
}
// 最初のカテゴリーが選択された時に子要素を取り出すajax通信
$('#category').change(function(e) {
e.preventDefault();
var parent = $(this).val();
console.log(parent)
$("#child-wrap").remove()
$("#grandchild-wrap").remove()
$.ajax({
  url: '/api/categories/new',
  type: 'GET',
  data: ('parent=' + parent),
  dataType: 'json' 
})
.done(function(child) {
    appendChildSelect(child)
    child.forEach(function(child) {
      appendChild(child)
    })
  })
.fail(function() {
  alert('errorが発生しました');
});

})
// 子カテゴリーが選択された際にその子要素を取り出すajax通信

$(document).on('change', '#child-category', function() {
    var child = $(this).val();
    $("#grandchild-wrap").remove()
    $.ajax({ 
      url: '/api/categories/new', 
      type: 'GET', 
      data: ('child=' + child), 
      dataType: 'json' 
    })


    .done(function(grandchild) {
      appendGrandChildSelect(grandchild)
      grandchild.forEach(function(grandchild) {
        appendGrandChild(grandchild)
      })
    })
    .fail(function() {
      alert('errorが発生しました');
    });
  });

})