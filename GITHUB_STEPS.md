# GitHub-та тапсыру қадамдары

1. GitHub-та **smart-home-management** атты Public репозиторий құрыңыз (README қоспаңыз).
2. **Description:** Web and IoT system for remotely controlling smart home devices.
3. **Topics:** smart-home, iot, uml, home-automation, diagrams
4. ZIP ішіндегі **smart-home-management** бумасын ашып, оның ішінде терминал іске қосыңыз.
5. Төмендегі командаларды ретімен орындаңыз. GitHub-тағы USERNAME орнына өз логиніңізді жазыңыз.

```bash
git init -b main
git remote add origin https://github.com/USERNAME/smart-home-management.git
git add README.md .gitignore GITHUB_STEPS.md
git commit -m "Add project README and repository guide"
git switch -c behavior-diagrams
git add docs/analysis/activity-control-light.drawio docs/analysis/activity-control-light.png
git commit -m "Add activity diagram for remote light control"
git add docs/analysis/sequence-control-light.drawio docs/analysis/sequence-control-light.png
git commit -m "Add sequence diagram for remote light control"
git add docs/analysis/SCENARIO.md
git commit -m "Document smart light control scenario"
git push -u origin behavior-diagrams
git push -u origin main
```

6. GitHub-та **Compare & pull request** → base: `main`, compare: `behavior-diagrams` → **Create pull request** → **Merge pull request**.
7. main ішіндегі README сілтемелерін басып тексеріңіз. Жетекшіге репозиторийдің URL-ын жіберіңіз.

**Маңызды:** Барлық commit командаларын көрсетілген ретпен орындаңыз. `SCENARIO.md` төртінші commit кезінде ғана қосылады.
