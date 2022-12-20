// Navigate from the home page to the product detail page by click on a product.

// Start with a copy of all the setip code from the home_page feature.
// Make sure you start by visiting the home page
// and then click one of the product partials in order to navigate directly to a product details page.
// Refer to the code in the _product.html.erb partial to determine how you are going to select the link to click.

/// <reference types="cypress" />

describe('example to-do app', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/products')
  });

  it("Navigate from the home page to the produce detail page by click on a product", () => {
    cy.get(".products article")
      .should("be.visible")
      .first()
      .find("a img")
      .click()

    cy.location('pathname')
      .should('not.eq', 'products')
      .should('include', 'products')
  });
})
