# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/step_by_step_navigation'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::StepByStepNavigation, type: :helper do
  include described_class

  let(:step_by_step_navigation_element) { Capybara::Node::Simple.new(result).find('.gem-c-step-nav') }

  describe '.govuk_step_by_step_navigation' do
    let(:result) { govuk_step_by_step_navigation(step_by_step_sections, **options) }
    let(:step_by_step_sections) do
      [
        {
          heading: {
            text: 'Join Ouroboros',
          },
          content: [
            {
              type: :paragraph,
              text: 'You must first join Ouroboros and gain the ability to interlink'
            }
          ]
        },
        {
          heading: {
            text: 'Get a some soldiers from Keves',
          },
          content: [
            {
              type: :list,
              items: [
                {
                  text: 'Noah'
                },
                {
                  text: 'Lanz'
                },
                {
                  text: 'Eunie'
                }
              ]
            }
          ]
        },
        {
          heading: {
            text: 'Get a some soldiers from Agnus',
          },
          content: [
            {
              type: :list,
              items: [
                {
                  text: 'Mio'
                },
                {
                  text: 'Sena'
                },
                {
                  text: 'Taion'
                }
              ]
            }
          ]
        },
        {
          heading: {
            text: 'Admit defeat and re-enter the cycle',
            logic: 'or'
          },
          content: [
            {
              type: :paragraph,
              text: 'It is over for you, you have succumbed to the will of Mobius'
            },
            {
              type: :list,
              items: [
                {
                  text: 'you will go back into the cycle',
                  no_marker: true
                },
                {
                  text: '10 more years of suffering',
                  no_marker: true
                },
                {
                  text: 'will the war ever end?',
                  no_marker: true
                }
              ]
            }
          ]
        }
      ]
    end
    let(:options) { {} }

    let(:default_html) do
      '
        <div class="gem-c-step-nav gem-c-step-nav--large gem-c-step-nav--active" data-module="govuk-step-by-step-navigation" data-show-text="Show" data-hide-text="Hide" data-show-all-text="Show all" data-hide-all-text="Hide all">
          <ol class="gem-c-step-nav__steps">
            <li class="gem-c-step-nav__step js-step" id="join-ouroboros">
              <div class="gem-c-step-nav__header js-toggle-panel" data-position="1">
                <h2 class="gem-c-step-nav__title">
                  <span class="gem-c-step-nav__circle gem-c-step-nav__circle--number">
                    <span class="gem-c-step-nav__circle-inner">
                      <span class="gem-c-step-nav__circle-background">
                        <span class="govuk-visually-hidden">
                          Step
                        </span>
                        1
                      </span>
                    </span>
                  </span>
                  <span class="js-step-title">
                    <span class="js-step-title-text">
                      Join Ouroboros
                    </span>
                  </span>
                </h2>
              </div>
              <div class="gem-c-step-nav__panel js-panel" id="step-panel-join-ouroboros-1">
                <p class="gem-c-step-nav__paragraph">
                  You must first join Ouroboros and gain the ability to interlink
                </p><
              /div>
            </li>
            <li class="gem-c-step-nav__step js-step" id="get-a-some-soldiers-from-keves">
              <div class="gem-c-step-nav__header js-toggle-panel" data-position="2">
                <h2 class="gem-c-step-nav__title">
                  <span class="gem-c-step-nav__circle gem-c-step-nav__circle--number">
                    <span class="gem-c-step-nav__circle-inner">
                      <span class="gem-c-step-nav__circle-background">
                        <span class="govuk-visually-hidden">
                          Step
                        </span>
                        2
                      </span>
                    </span>
                  </span>
                  <span class="js-step-title">
                    <span class="js-step-title-text">
                      Get a some soldiers from Keves
                    </span>
                  </span>
                </h2>
              </div>
              <div class="gem-c-step-nav__panel js-panel" id="step-panel-get-a-some-soldiers-from-keves-2">
                <ul class="gem-c-step-nav__list gem-c-step-nav__list--choice" data-length="3">
                  <li class="gem-c-step-nav__list-item js-list-item">
                    <span>Noah</span>
                  </li>
                  <li class="gem-c-step-nav__list-item js-list-item">
                    <span>Lanz</span>
                  </li>
                  <li class="gem-c-step-nav__list-item js-list-item">
                    <span>Eunie</span>
                  </li>
                </ul>
              </div>
            </li>
            <li class="gem-c-step-nav__step js-step" id="get-a-some-soldiers-from-agnus">
              <div class="gem-c-step-nav__header js-toggle-panel" data-position="3">
                <h2 class="gem-c-step-nav__title">
                  <span class="gem-c-step-nav__circle gem-c-step-nav__circle--number">
                    <span class="gem-c-step-nav__circle-inner">
                      <span class="gem-c-step-nav__circle-background">
                        <span class="govuk-visually-hidden">
                          Step
                        </span>
                        3
                      </span>
                    </span>
                  </span>
                  <span class="js-step-title">
                    <span class="js-step-title-text">
                      Get a some soldiers from Agnus
                    </span>
                  </span>
                </h2>
              </div>
              <div class="gem-c-step-nav__panel js-panel" id="step-panel-get-a-some-soldiers-from-agnus-3">
                <ul class="gem-c-step-nav__list gem-c-step-nav__list--choice" data-length="3">
                  <li class="gem-c-step-nav__list-item js-list-item">
                    <span>Mio</span>
                  </li>
                  <li class="gem-c-step-nav__list-item js-list-item">
                    <span>Sena</span>
                  </li>
                  <li class="gem-c-step-nav__list-item js-list-item">
                    <span>Taion</span>
                  </li>
                </ul>
              </div>
            </li>
            <li class="gem-c-step-nav__step js-step" id="admit-defeat-and-re-enter-the-cycle">
              <div class="gem-c-step-nav__header js-toggle-panel" data-position="4">
                <h2 class="gem-c-step-nav__title">
                  <span class="gem-c-step-nav__circle gem-c-step-nav__circle--logic">
                    <span class="gem-c-step-nav__circle-inner">
                      <span class="gem-c-step-nav__circle-background">
                        <span class="govuk-visually-hidden">
                          Step
                        </span>
                        or
                      </span>
                    </span>
                  </span>
                  <span class="js-step-title">
                    <span class="js-step-title-text">
                      Admit defeat and re-enter the cycle
                    </span>
                  </span>
                </h2>
              </div>
              <div class="gem-c-step-nav__panel js-panel" id="step-panel-admit-defeat-and-re-enter-the-cycle-4">
                <p class="gem-c-step-nav__paragraph">
                  It is over for you, you have succumbed to the will of Mobius
                </p>
                <ul class="gem-c-step-nav__list gem-c-step-nav__list--choice" data-length="3">
                  <li class="gem-c-step-nav__list-item js-list-item gem-c-step-nav__list--no-marker">
                    <span>you will go back into the cycle</span>
                  </li>
                  <li class="gem-c-step-nav__list-item js-list-item gem-c-step-nav__list--no-marker">
                    <span>10 more years of suffering</span>
                  </li>
                  <li class="gem-c-step-nav__list-item js-list-item gem-c-step-nav__list--no-marker">
                    <span>will the war ever end?</span>
                  </li>
                </ul>
              </div>
            </li>
          </ol>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the step by step naviagtion steps' do
        expect(step_by_step_navigation_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_step_by_step_navigation(step_by_step_sections) }

      it 'correctly formats the HTML with the step by step naviagtion steps' do
        expect(step_by_step_navigation_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the the custom class' do
        expect(step_by_step_navigation_element[:class]).to eq 'gem-c-step-nav gem-c-step-nav--large gem-c-step-nav--active my-custom-class'
      end
    end

    context 'when the id is passed' do
      let(:options) { { attributes: { id: 'my-custom-id' } } }

      it 'has the the custom id' do
        expect(step_by_step_navigation_element[:id]).to eq 'my-custom-id'
      end
    end

    context 'when show and hide text is passed' do
      let(:options) { { attributes: { data: { 'show-text': 'Show it', 'hide-text': 'Hide it', 'show-all-text': 'Show it all', 'hide-all-text': 'Hide it all' } } } }

      # rubocop:disable RSpec/MultipleExpectations
      it 'use the custom show and hide text' do
        expect(step_by_step_navigation_element[:'data-show-text']).to eq 'Show it'
        expect(step_by_step_navigation_element[:'data-hide-text']).to eq 'Hide it'
        expect(step_by_step_navigation_element[:'data-show-all-text']).to eq 'Show it all'
        expect(step_by_step_navigation_element[:'data-hide-all-text']).to eq 'Hide it all'
      end
      # rubocop:enable RSpec/MultipleExpectations
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' }, test: 'what is up' } } }

      it 'adds the additional attributes' do
        expect(step_by_step_navigation_element[:'data-test']).to eq 'hello there'
        expect(step_by_step_navigation_element[:test]).to eq 'what is up'
      end
    end
  end
end
