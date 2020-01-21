$(document).on('turbolinks:load', function() {
    // $("#catBtn").hide();
    function appendChildcategory(child) {
      let html = `<li class="childcategoryTree--item" data-category_id="${child.id}">
                    <a href>${child.name}</a>
                  </li>`
      return html; 
    }

    function appendGrandcategory(child) {
        let html = `<li class="grandcategoryTree--item" data-category_id="${child.id}">
                      <a href>${child.name}</a>
                    </li>`
        return html; 
      }

    $('#catBtn').hover(function(){
        $('.tree').removeClass('displayNone')
    }, function(){
        // $('.tree').addClass('displayNone')
    });

    $(document).on('mouseover', '.categoryTree--item', function(){
        $('.childcategoryTree').empty()
        $('.grandchildcategoryTree').empty()
        let categoryId = $(this).data('category_id')
        $.ajax({
            url: '/products/category_child',
            type: 'GET',
            data: {category_id: categoryId},
            dataType: 'json'
        })
        .done(function(childCategory) {
            console.log(childCategory)
            childCategory.forEach(function(category){
                let html = appendChildcategory(category)
                $('.childcategoryTree').append(html)
            });
        })
        .fail(function() {
            alert('errorが発生しました');
        });
    })

    $(document).on('mouseover', '.childcategoryTree--item', function(){
        $('.grandchildcategoryTree').empty()
        let categoryId = $(this).data('category_id')
        $.ajax({
            url: '/products/category_child',
            type: 'GET',
            data: {category_id: categoryId},
            dataType: 'json'
        })
        .done(function(category) {
            console.log(category)
            category.forEach(function(category){
                let html = appendGrandcategory(category)
                $('.grandchildcategoryTree').append(html)
            });
        })
        .fail(function() {
            alert('errorが発生しました');
        });
    })

    $(document).on('mouseleave', '.tree', function(){
        $('.tree').addClass('displayNone')
        $('.childcategoryTree').empty()
        $('.grandchildcategoryTree').empty()
    });

    
});