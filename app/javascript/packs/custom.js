'use strict';

document.addEventListener("DOMContentLoaded", function() {

  console.log('DLF Forum Voting');

  // @see https://wttech.blog/blog/2020/css-transitions-and-reduced-motion/
  const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion)').matches;
  // console.log(prefersReducedMotion);

  // @see https://codepen.io/joshuamasen/pen/OYaYbL
  // Set a variable for our button element.
  const scrollToTopButton = document.getElementById('js-top');

  // Let's set up a function that shows our scroll-to-top button if we scroll beyond the height of the initial window.
  const scrollFunc = () => {
    // Get the current scroll value
    let y = window.scrollY;

    // If the scroll value is greater than the window height, let's add a class to the scroll-to-top button to show it!
    if (y > 0) {
      scrollToTopButton.className = "top-link show";
    } else {
      scrollToTopButton.className = "top-link hide";
    }
  };

  window.addEventListener("scroll", scrollFunc);

  const scrollToTop = () => {
    // TODO: check media preference; don't smooth scroll if reduced motion is selected

    // Let's set a variable for the number of pixels we are from the top of the document.
    const c = document.documentElement.scrollTop || document.body.scrollTop;

    // If that number is greater than 0, we'll scroll back to 0, or the top of the document.
    // We'll also animate that scroll with requestAnimationFrame:
    // https://developer.mozilla.org/en-US/docs/Web/API/window/requestAnimationFrame
    window.scrollTo(0,0);

    // if (c > 0) {
    //   window.requestAnimationFrame(scrollToTop);
    //   // ScrollTo takes an x and a y coordinate.
    //   // Increase the '10' value to get a smoother/slower scroll!
    //   window.scrollTo(0, c - c / 10);
    // }
  };


  // When the button is clicked, run our ScrolltoTop function above!
  scrollToTopButton.onclick = function(e) {
    e.preventDefault();
    scrollToTop();
  }

  // @see https://codepen.io/tutsplus/pen/WNrQbGr
  const navLinks = document.querySelectorAll('.media');
  // console.log('navLinks', navLinks);
  for (const link of navLinks) {
    link.addEventListener('click', clickHandler);
    // console.log('link', link);
  }

  function clickHandler(e) {
    e.preventDefault();
    const href = this.getAttribute('href');
    const offsetTop = document.querySelector(href).offsetTop;
    // console.log('href', href);
    // console.log('offset', offsetTop);

    if (!prefersReducedMotion) {
      scroll({
        top: offsetTop,
        behavior: "smooth"
      });
    } else {
      scroll({
        top: offsetTop
      });
    }

  }

});