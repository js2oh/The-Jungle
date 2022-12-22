/// <reference types="cypress" />

describe('User Authentication', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/products')
  });

  it("Sign-up Process", () => {
    cy.get('[data-bs-toggle="dropdown"]')
      .last()
      .click()
      .next()
      .children()
      .last()
      .should("include.text", "Sign Up")
      .find("a.nav-link")
      .click()

    cy.location('pathname')
      .should('eq', '/signup')

    cy.get('input#user_first_name')
      .type('Charlie', { delay: 50 })
      .should('have.value', 'Charlie')

    cy.get('input#user_last_name')
      .type('Oh', { delay: 50 })
      .should('have.value', 'Oh')

    cy.get('input#user_email')
      .type('taxdouble@gmail.com', { delay: 50 })
      .should('have.value', 'taxdouble@gmail.com')

    cy.get('input#user_password')
      .type('12345asdfg', { delay: 50 })
      .should('have.value', '12345asdfg')

    cy.get('input#user_password_confirmation')
      .type('12345asdfg', { delay: 50 })
      .should('have.value', '12345asdfg')

    cy.get('[data-disable-with="Sign Up"]')
      .click()
  });

  it("Sign-in Process", () => {
    cy.get('[data-bs-toggle="dropdown"]')
      .last()
      .click()
      .next()
      .contains('Sign In')
      .click()

    cy.location('pathname')
      .should('eq', '/login')

    cy.get('input#email')
      .type('taxdouble@gmail.com', { delay: 50 })
      .should('have.value', 'taxdouble@gmail.com')

    cy.get('input#password')
      .type('12345asdfg', { delay: 50 })
      .should('have.value', '12345asdfg')

    cy.get('[data-disable-with="Sign In"]')
      .click()

    cy.location('pathname')
      .should('eq', '/')

    cy.get('[data-bs-toggle="dropdown"]')
      .last()
      .should('contain.text', 'Charlie')
  });
})
