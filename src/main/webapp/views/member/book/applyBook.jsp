<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Knock Book</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
      crossorigin="anonymous"
    />
<style>
	body{
	 background-color: rgb(247, 247, 247);
	}
	h2{
		margin-bottom : 30px;
	}
	.write_container {
         display: flex;
         justify-content: center;
         align-items: center;
         height: 50vh;
     }
     .form_write {
         padding: 7rem;
         border : 1px solid gray;
         border-radius: 10px;
         width: 50vw;
         height : 600px;
         margin-left : 110px;
         margin-top : 70px;
     }
     .form_write input, .form_write textarea {
         width: 100%;
         padding: 10px;
         margin-bottom: 1rem;
         border: 1px solid #ced4da;
         border-radius: 5px;
         transition: border-color 0.2s;
     }
     .form_write input:focus, .form_write textarea:focus {
         border-color: #80bdff;
         outline: none;
     }
     .bw_btn {
         text-align: right;
     }
     .btn-custom {
         background-color: #6c757d;
         color: white;
     }
     .btn-custom:hover {
         background-color: #5a6268;
     }

</style>
  </head>
<% Boolean success = (Boolean) request.getAttribute("success"); %>
<% if (success != null && success) { %>
    <script type="text/javascript">
        alert("신청이 완료되었습니다");
    </script>
<% } %>
    <form class="form_write" id="create_account_form" name="create_account_form" action="/book/applyEnd" method="post">
      <h2>도서 신청</h2>
      <div class="apply">
           <div>
           <label for ="apply_bk_title">도서이름</label>
                <input type="text"
                 name="apply_bk_title"
                 id="apply_bk_title"
                 placeholder="ex) 돼지가족"
                 style="width: 100%" required/>

           </div>
           <div>
           <label for ="apply_bk_publisher">출판사</label>
           <input type="text"
           id="apply_bk_publisher"
           name="apply_bk_publisher"
           placeholder="ex) 샘율출판사"
            style="width: 100%" required
           />
           </div>
           <div>
            <label for ="apply_bk_author">저자</label>
              <input type="text"
               id="apply_bk_author"
               name="apply_bk_author"
               placeholder="ex) 브라이언"
                 style="width: 100%" required/>
                  </div>
               <div class="bw_btn">
                 <button type="submit" class="btn btn-secondary">신청</button>
               </div>
             </div>
           </form>
    </div>
<script>
 document.addEventListener('DOMContentLoaded', function() {
     var form = document.getElementById('create_account_form');

     form.addEventListener('submit', function(event) {
         var inputs = form.querySelectorAll('input[required]');
         var allFilled = Array.from(inputs).every(input => input.value.trim() !== '');

         if (!allFilled) {
             alert('모든 필드를 작성해 주세요.');
             event.preventDefault(); // 폼 제출을 막음
         }
     });
 });
  
document.addEventListener("DOMContentLoaded", function() {
    const menuItems = document.querySelectorAll(".menu-item > a");

    menuItems.forEach(function(item) {
        const submenu = item.nextElementSibling;
        let isOpen = false;

        item.addEventListener("click", function(event) {
            if (submenu) {

                if (isOpen) {
                    submenu.style.animation = "slide-up 0.3s ease";
                    
                    setTimeout(function(){
                        submenu.style.display = "none";
                        submenu.style.animation = "";
                    }, 300);

                    isOpen = false;
                } else {
                    submenu.style.display = "block";
                    submenu.style.height = "auto";
                    void submenu.offsetWidth;
                    submenu.style.animation = "slide-down 0.3s ease";
                    submenu.style.height = submenu.scrollHeight + "px";

                    isOpen = true;
                }
            }
        });
    });

    const submenuLinks = document.querySelectorAll(".submenu li a");
    submenuLinks.forEach(function(link) {
        link.addEventListener("click", function(event) {
        });
    });
}); 
</script>
</html>