// $(document).on('turbolinks:load', ()=> {
//   // 画像用のinputを生成する関数
//   const buildFileField = (num)=> {
//     const html = `<div data-index="${num}" class="js-file_group">
//                       <input class="js-file" type="file"
//                       name="product[images_attributes][${num}][src]"
//                       id="product_images_attributes_${num}_src"><br>
//                   </div>`;
//     return html;
//   };
//     // プレビュー用のimgタグを生成する関数
//   const buildImg = (index, url)=> {
//     const html = `<div class="preview_js">
//                     <img data-index="${index}" src="${url}" width="157px" height="187px">
//                     <div class="edit" data-index="${index}">編集</div><div class="delete js-remove_preview">削除</div>
//                   </div>`;
//     return html;
//   };

//   // file_fieldのnameに動的なindexをつける為の配列
//   let fileIndex = [1,2,3,4,5,6,7,8,9,10];
//   // 既に使われているindexを除外
//   lastIndex = $('.js-file_group:last').data('index');
//   fileIndex.splice(0, lastIndex);

//   $('.hidden-destroy').hide();

//   $()

//   $('#image-box').on('change', '.js-file', function(e) {
//     console.log('test1')
//     console.log($(this))
//     const targetIndex = $(this).parent().data('index');
//     // ファイルのブラウザ上でのURLを取得する
//     console.log(targetIndex)
//     const file = e.target.files[targetIndex];
//     console.log(file)
//     const blobUrl = window.URL.createObjectURL(file);

//     // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
//     if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
//       img.setAttribute('src', blobUrl);
//     }
//     else {  // 新規画像追加の処理
//       $('#preview-box').append(buildImg(targetIndex, blobUrl));

//       // fileIndexの先頭の数字を使ってinputを作る
//       if ($('.js-file').length <=3){
//         $('#image-box').append(buildFileField(fileIndex[0]));
//         fileIndex.shift();
//         // 末尾の数に1足した数を追加する
//         fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
//       }
//     };
//     // $('')addClass()
//   });
//   // editボタン
//   // $(document).on('click', '.edit', function(e) {
//   //   console.log('test5')
//   //   const targetIndex = $(this).data('index');
//   //   console.log(targetIndex)
//   //   // ファイルのブラウザ上でのURLを取得する
//   //   const file = e.target.files[0];
//   //   const blobUrl = window.URL.createObjectURL(file);

//   //   // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
//   //   if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
//   //     img.setAttribute('src', blobUrl);
//   //   }
//   //   else {  // 新規画像追加の処理
//   //     $('#preview-box').append(buildImg(targetIndex, blobUrl));

//   //     // fileIndexの先頭の数字を使ってinputを作る
//   //     if ($('.js-file').length <=3){
//   //       $('#image-box').append(buildFileField(fileIndex[0]));
//   //       fileIndex.shift();
//   //       // 末尾の数に1足した数を追加する
//   //       fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
//   //     }
//   //   };
//   //   // $('')addClass()
//   // });

//   // deleteボタン
//   $(document).on('click', '.js-remove_preview', function() {
//     console.log('test2')
//     const targetIndex = $(this).parent().data('index');
//     // 該当indexを振られているチェックボックスを取得する
//     const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
//     // もしチェックボックスが存在すればチェックを入れる
//     if (hiddenCheck) hiddenCheck.prop('checked', true);

//     $(this).parent().remove();
//     $(`img[data-index="${targetIndex}"]`).remove();

//     // 画像入力欄が0個にならないようにしておく
//     if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
//   });

//   $('#product_price').on('keyup', function() {
//     var input = parseInt($("#product_price").val());
//     if (input >= 300 ) {
//     }
//     else{
//     }
//   });
// });

$(document).on('turbolinks:load', ()=> {
  // 画像用のinputを生成する関数
  const buildFileField = (num)=> {
    const html = `<label class="js-file_group" data-index="${num}" for="product_images_attributes_${num}_src">
                    <input class="js-file" type="file"
                    name="product[images_attributes][${num}][src]"
                    id="product_images_attributes_${num}_src"><br>
                  </label>`;
    return html;
  }
  // プレビュー用のimgタグを生成する関数
  const buildImg = (index, url)=> {
    const html = `<div class="preview">
                    <img data-index="${index}" src="${url}" width="126.6px" height="187px">
                    <label for="product_images_attributes_${index}_src" class="js-edit" data-index="${index}">編集</label>
                    <div class="js-remove" data-index="${index}">削除</div>
                  </div>
                 `;
    return html;
  }

  // file_fieldのnameに動的なindexをつける為の配列
  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  // 既に使われているindexを除外
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);

  $('.hidden-destroy').hide();

  $('#image-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    $('.js-file_group').eq(targetIndex).addClass('none')
    // ファイルのブラウザ上でのURLを取得する
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {  // 新規画像追加の処理
        let imageLength = $(".preview").length
        console.log(imageLength)
        if (imageLength < 5){
        $('#previews1').append(buildImg(targetIndex, blobUrl));
        } else if (imageLength < 10){
          $('.js-file_group').eq(targetIndex +1).addClass('none')
          $('.previews2').addClass('display-flex')
          $('.previews2').append(buildImg(targetIndex, blobUrl));
        } else {
          
        }
      // fileIndexの先頭の数字を使ってinputを作る
      $('#image-box').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      // 末尾の数に1足した数を追加する
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    }
  });

  $('#image-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index');
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();

    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));
  });
});