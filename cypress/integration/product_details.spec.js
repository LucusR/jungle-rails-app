describe("Product Details", () => {
  it("should navigate from homepage to product detail page by clicking on a product", () => {
    cy.visit("/");
    cy.get(".products article").first()
      .click();
  });
});