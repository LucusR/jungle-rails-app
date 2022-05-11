describe("Cart", () => {
  it("Adds an item to cart", () => {
    cy.visit("/");
    cy.get(".products article div form button").first()
      .click({force: true});
    cy.get()
    cy.visit("/cart");
    cy.get("cart-empty-alert").should('not.exist');
  });
});