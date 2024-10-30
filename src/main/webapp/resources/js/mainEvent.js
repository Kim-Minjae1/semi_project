let slideIndex = 0;
    let slides = document.getElementsByClassName("slide");
    let intervalId;

    function startSlideShow() {
        showSlides(slideIndex);
        intervalId = setInterval(() => {
            slideIndex++;
            showSlides(slideIndex);
        }, 3000);
    }

    function showSlides(n) {
        if (n >= slides.length) {
            slideIndex = 0;
        } else if (n < 0) {
            slideIndex = slides.length - 1;
        }

        for (let i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }

        slides[slideIndex].style.display = "block";
    }

    function plusSlides(n) {
        clearInterval(intervalId);
        let newIndex = slideIndex + n;

        if (newIndex >= slides.length) {
            slideIndex = 0;
        } else if (newIndex < 0) {
            slideIndex = slides.length - 1;
        } else {
            slideIndex = newIndex;
        }

        showSlides(slideIndex);
        startSlideShow(); // 이전/다음 버튼 클릭 시 자동 슬라이드 재시작
    }

    startSlideShow();