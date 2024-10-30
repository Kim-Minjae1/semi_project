<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="com.book.member.user.vo.User"%>
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
   crossorigin="anonymous" />
<style>
	* {
	   margin: 0;
	   padding: 0;
	   box-sizing: border-box;
	} 
	
	::-webkit-scrollbar {
		display: none;
	} 
	
	body {
	   background-color: rgb(247, 247, 247);
	   -ms-overflow-style: none;
	}
	.form {
	   background-color: white; 
	}
	#create_sg_form{
	   margin : 30px; 
	}
	.sgDiv {
	   display: flex;
	   flex-direction: column;
	   padding: 30px;
	   margin-top: 20px;
	   width: 600px;
	   margin: 0 auto;
	}
	
	.sgTitle {
	   width: 100%;
	   height: 50px;
	   padding: 10px;
	   line-height: 1.5;
	   border: 1px solid #575756;
	   border-radius: 15px;
	   background: #fff;
	   font-size: 18px;
	   outline: none;
	   resize: none;
	   overflow-wrap: break-word;
	   margin-bottom: 10px;
	}
	
	#sgForm {
	   width: 600px;
	   height: 550px;
	}
	
	.sgWrite {
	   width: 100%;
	   height: 480px;
	   padding: 10px;
	   line-height: 1.5;
	   border: 1px solid #575756;
	   border-radius: 15px;
	   background: #fff;
	   font-size: 18px;
	   outline: none;
	   resize: none;
	   overflow-wrap: break-word; 
	   margin-bottom: 10px;
	}
	
	.image-preview {
	   display: inline-block;
	   margin: 5px;
	}
	
	.image-preview img {
	   width: 150px;
	   height: 200px;
	   object-fit: cover;
	}
	
	#btn_gr {
	    gap: 10px;
	    display: flex;
	    justify-content: right;
	    margin-right: 30px;
	}
	
	#imgBtn{
	margin-top:15px;
	margin-bottom:15px;
	}
	
	.btn {
	  width: 50px;
	  height: 30px;
	  border-radius: 15%;
	  text-align: center;
	  background: #575756;
	  color: #fffbfb;
	  font-size: 14px;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  cursor: pointer;
	  text-decoration: none;
	  border: none;
	}
	
	.btn:hover {
	   background: #18283235;
	}
</style>
</head>
   <%
   Boolean success = (Boolean) request.getAttribute("success");
   %>
   <%
   if (success != null && success) {
   %>
   <script type="text/javascript">
        alert("신청이 완료되었습니다");
    </script>
   <%
   }
   %>
   <form action="/member/sg/createEnd" id="create_sg_form" method="post" enctype="multipart/form-data">
      <input type="text" class="sgTitle" name="sg_title" placeholder="제목을 작성해 주세요" required>
      <textarea class="sgWrite" name="sg_content" placeholder="문의사항 작성 시 주의할 점 
      1. 가능한 한 명확하고 구체적으로 작성해 주세요.
       2. 필요한 경우 관련된 정보나 배경 설명을 포함해 주세요
       3. 이미지파일은 3개까지만 등록 가능합니다."required></textarea>
      <div id="imageContainer" class="image-container">
      <!-- 이미지를 보여줄 컨테이너 --></div>
      <div id="imgBtn">
      <input type="file" name="sg_file1" accept=".png,.jpg,.jpeg">
      <input type="file" name="sg_file2" accept=".png,.jpg,.jpeg">
      <input type="file" name="sg_file3" accept=".png,.jpg,.jpeg">
      <%User sg_userNo = (User) session.getAttribute("user");%>
      </div>
      <input type="hidden" name="user_no"value="<%=sg_userNo.getUser_no()%>">
      <div id="btn_gr">
         <input type="button" class="btn" value="등록" onclick="createSgForm();"> 
         <input type="reset"class="btn" value="취소">
      </div>
   </form>

<script type="text/javascript">
// 폼 유효성 검사 함수
function createSgForm() {
    let form = document.getElementById('create_sg_form');
    if (!form.sg_title.value) {
        alert("제목을 입력하세요.");
        form.sg_title.focus();
    } else if (!form.sg_content.value) {
        alert("내용을 입력하세요.");
        form.sg_content.focus();
    } else {
        let validImages = true;
        // 이미지 파일 유효성 검사
        const fileInputs = document.querySelectorAll('input[type="file"]');
        fileInputs.forEach(input => {
            if (input.value) {
                const file = input.files[0];
                const fileType = file.type.split('/')[1];
                if (!(fileType === 'jpg' || fileType === 'jpeg' || fileType === 'png')) {
                    validImages = false;
                }
            }
        });

        if (!validImages) {
            alert("이미지 파일은 .jpg, .jpeg, .png 형식만 업로드 가능합니다.");
        } else {
            form.submit();
        }
    }
}

</script>
</html>