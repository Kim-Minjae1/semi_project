function showFormSection() {
    const formSections = document.querySelectorAll('.form-section');
    formSections.forEach(section => {
        section.style.display = 'none';
    });

    const selectedOption = document.getElementById('eventType').value;
    document.getElementById('form-section' + selectedOption).style.display = 'block';
    
    validateForm();  
}

function toggleEndDate(section) {
    const startDate = document.getElementById('startDate' + section).value;
    const endDate = document.getElementById('endDate' + section);

    if (startDate) {
        endDate.disabled = false;
        endDate.min = startDate;
    } else {
        endDate.disabled = true;
        endDate.value = '';
    }
    
    validateForm(); 
}

function setMinValue() {
    const startDate2 = document.getElementById('startDate2');
    const endDate2 = document.getElementById('endDate2');

    if (startDate2.value) {
        endDate2.disabled = false;
        endDate2.min = startDate2.value;
    } else {
        endDate2.disabled = true;
        endDate2.value = '';
    }
    
    validateForm(); 
}

function previewImage(event, section) {
    const inputFile = event.target;
    const file = inputFile.files[0];
    const fileType = file.type;
    const validImageTypes = ['image/jpeg', 'image/png', 'image/jpg'];
    
    if (!validImageTypes.includes(fileType)) {
        alert("JPG, JPEG, PNG 파일만 업로드 가능합니다.");
        inputFile.value = '';
        return;
    }

    const reader = new FileReader();
    reader.onload = function() {
        const preview = document.getElementById('imagePreview' + section);
        preview.src = reader.result;
        preview.style.display = 'block';

        const imageBox = document.getElementById('imageBox' + section);
        imageBox.classList.remove('default');

        const deleteButton = document.getElementById('deleteButton' + section);
        deleteButton.style.display = 'block';
    };
    reader.readAsDataURL(file);
    
    validateForm();  
}

function deleteImage(section) {
    const preview = document.getElementById('imagePreview' + section);
    preview.src = '';
    preview.style.display = 'none';

    const imageBox = document.getElementById('imageBox' + section);
    imageBox.classList.add('default');

    const deleteButton = document.getElementById('deleteButton' + section);
    deleteButton.style.display = 'none';

    const inputFile = document.getElementById('eventimage' + section);
    inputFile.value = '';
    
    validateForm(); 
}

function validateForm() {
    const eventType = document.getElementById('eventType').value;
    let isValid = true;

    if (eventType === '1') { // 기본 이벤트
        const title = document.getElementById('eventTitle1').value.trim();
        const startDate = document.getElementById('startDate1').value.trim();
        const content = document.getElementById('eventContent1').value.trim();
        const image = document.getElementById('eventimage1').value.trim();

        if (!title || !startDate || !content || !image) {
            isValid = false;
        }
    } else if (eventType === '2') { // 선착순 이벤트
        const title = document.getElementById('eventTitle2').value.trim();
        const startDate = document.getElementById('startDate2').value.trim();
        const endDate = document.getElementById('endDate2').value.trim();
        const progressDate = document.getElementById('progressDate2').value.trim();
        const quota = document.getElementById('eventQuota2').value.trim();
        const content = document.getElementById('eventContent2').value.trim();
        const image = document.getElementById('eventimage2').value.trim();

        if (!title || !startDate || !endDate || !progressDate || !quota || !content || !image) {
            isValid = false;
        }

        if (progressDate && endDate && progressDate <= endDate) {
            isValid = false;
            alert('이벤트 진행일은 모집 종료일 이후여야 합니다.');
        }
    }

    const insertBtn = document.getElementById('eventInsertBtn');
    if (isValid) {
        insertBtn.disabled = false;
        insertBtn.classList.add('enabled');
    } else {
        insertBtn.disabled = true;
        insertBtn.classList.remove('enabled');
    }
}


function eventInsertBtn() { 
    const form = document.create_evnt_form;
    form.submit();
}

document.addEventListener('DOMContentLoaded', function() {
    showFormSection();
    document.querySelectorAll('input, textarea, select').forEach(element => {
        element.addEventListener('input', validateForm);
        element.addEventListener('change', validateForm);
    });
});
