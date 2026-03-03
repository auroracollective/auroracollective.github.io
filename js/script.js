document.addEventListener('DOMContentLoaded', () => {
  const toggleButton = document.querySelector('.toggle-button');
  const navbarLinks = document.querySelector('.navbar-links');
  const mobileMenu = document.querySelector('.mobile-menu');

  if (toggleButton) {
    toggleButton.addEventListener('click', () => {
      if (mobileMenu) mobileMenu.classList.toggle('active');
      toggleButton.classList.toggle('active');
    });
  }

  showSlide(currentSlide);
  setInterval(nextSlide, 3000); // Change slide every 3 seconds
});

let currentSlide = 0;

function showSlide(index) {
  const slides = document.querySelectorAll('.carousel-item');
  if (index >= slides.length) {
    currentSlide = 0;
  } else if (index < 0) {
    currentSlide = slides.length - 1;
  } else {
    currentSlide = index;
  }
  const offset = -currentSlide * 100;
  document.querySelector('.carousel-inner').style.transform = `translateX(${offset}%)`;
}

function nextSlide() {
  showSlide(currentSlide + 1);
}