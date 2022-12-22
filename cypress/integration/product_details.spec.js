/// <reference types="cypress" />

describe('Product Details Page', () => {
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
