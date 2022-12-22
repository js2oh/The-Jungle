/// <reference types="cypress" />

describe('Add to Cart', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/products')
  });

  it("Add to cart by clicking on an add button", () => {
    cy.get('[data-bs-toggle="dropdown"]')
      .last()
      .click()
      .next()
      .children()
      .first()
      .find("a.nav-link")
      .as('cart')
      .then(($link) => {
        const count = $link.text().split(/[\(\)]/)[1]
        cy.wrap(count).as('count')
      })

    cy.get(".products article")
      .should("be.visible")
      .first()
      .find("div button.btn")
      .click({ force: true })

    cy.get('@count')
      .then((count) => {
        cy.get('@cart')
          .should('include.text', `${Number(count) + 1}`)
      })
  });
})
