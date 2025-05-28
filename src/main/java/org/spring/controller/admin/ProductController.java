package org.spring.controller.admin;

import java.util.List;
import java.util.Optional;

import org.spring.domain.Products;
import org.spring.service.ProductService;
import org.spring.service.UploadService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/admin")
public class ProductController {
	private final ProductService productService;
	private final UploadService uploadService;

	public ProductController(ProductService productService, UploadService uploadService) {
		this.productService = productService;
		this.uploadService = uploadService;
	}

	// list
	@GetMapping("/product")
	public String ListProduct(Model model, @RequestParam("page") Optional<String> optional,
			@RequestParam("name") Optional<String> nameOptional) {
		int page = 1;
		try {
			if (optional.isPresent()) {
				page = Integer.parseInt(optional.get());
			}
		} catch (NumberFormatException e) {

		}
		String name = nameOptional.orElse("");
		Pageable pageable = PageRequest.of(page - 1, 5);
		Page<Products> pageList = productService.fetchProductPage(pageable);
		List<Products> list = pageList.getContent();
		model.addAttribute("product", list);
		// Page
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPage", pageList.getTotalPages());

		return "admin/product/list";
	}

	// delete
	@GetMapping("/product/delete/{id}")
	public String deleteProduct(Model model, @PathVariable long id) {
		model.addAttribute("id", id);
		model.addAttribute("product", new Products());
		return "admin/product/delete";
	}

	@PostMapping("/product/delete/{id}")
	public String deleteProduct(@PathVariable long id, @ModelAttribute Products products) {
		productService.deleteProductById(products.getId());
		return "redirect:/admin/product";
	}

	// viewProduct
	@GetMapping("/product/view/{id}")
	public String productDetail(@PathVariable long id, Model model) {
		Products product = productService.getById(id);
		model.addAttribute("id", id);
		model.addAttribute("product", product);
		return "admin/product/view";
	}

	// createProduct
	@GetMapping("/product/create")
	public String createProduct(Model model) {
		model.addAttribute("product", new Products());
		return "admin/product/create";
	}

	@PostMapping("/product/create")
	public String createProduct(@ModelAttribute("product") @Valid Products products,
			@RequestParam("avatarPath") MultipartFile multipartFile, BindingResult result, Model model) {
		if (result.hasErrors()) {
			return "redirect:/admin/product/create";
		}
		// createImage
		String image = uploadService.handleSaveUploadFile(multipartFile, "product");
		products.setImage(image);
		productService.createProduct(products);

		return "redirect:/admin/product";
	}

	// updateProduct
	@GetMapping("product/update/{id}")
	public String productUpdate(@PathVariable long id, Model model) {
		Products newProduct = productService.getById(id);
		model.addAttribute("newProduct", newProduct);
		model.addAttribute("id", id);
		return "admin/product/update";
	}

	@PostMapping("product/update")
	public String productUpdate(@ModelAttribute("newProduct") @Valid Products products, BindingResult bindingResult,
			@RequestParam("avatarPath") MultipartFile multipartFile) {
		Products currentProduct = productService.getById(products.getId());
		if (currentProduct != null) {
			currentProduct.setDetailDesc(products.getDetailDesc());
			currentProduct.setFactory(products.getFactory());
			currentProduct.setName(products.getName());
			currentProduct.setPrice(products.getPrice());
			currentProduct.setQuantity(products.getQuantity());
			currentProduct.setShortDesc(products.getShortDesc());
			currentProduct.setSold(products.getSold());
			currentProduct.setTarget(products.getTarget());
			// update Image
			String image = uploadService.handleSaveUploadFile(multipartFile, "product");
			currentProduct.setImage(image);
			productService.createProduct(currentProduct);
		}

		return "redirect:/admin/product";
	}

}
