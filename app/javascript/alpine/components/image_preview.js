window.imagePreview = function () {
  return {
    images: [],

    previewImages(event) {
      this.images = [];

      const files = event.target.files;

      [...files].forEach((file) => {
        if (!file.type.startsWith("image/")) {
          return;
        }

        const reader = new FileReader();

        reader.onload = (event) => {
          this.images.push(event.target.result);
        };

        reader.readAsDataURL(file);
      });
    },
  };
};
